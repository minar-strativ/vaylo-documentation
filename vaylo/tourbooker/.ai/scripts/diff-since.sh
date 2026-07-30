#!/usr/bin/env bash
# diff-since.sh <anchor-field> [--include-doc]
#
# Deterministic, zero-token gate used by Maintain and Audit mode instead of having
# the AI run and interpret raw `git diff` itself.
#
# For every feature in inventory.json that has <anchor-field> set, diffs that
# feature's file globs (+ any shared_modules that list it in used_by) against the
# commit in <anchor-field>..HEAD.
#
# Multi-repo mode: if .ai/metadata/project.json sets "source_repo", code diffing
# (globs, anchors) runs against THAT repo, not the repo this script itself lives
# in — this is what lets .ai/ + docs/product/ live in a separate docs repo while
# the code they describe lives in its own repo. inventory.json/progress.json/docs
# always resolve relative to THIS repo (the docs repo); only git diff/cat-file
# calls redirect to source_repo.
#
# --include-doc drift detection is topology-dependent:
#   - same-repo mode (no source_repo configured): the doc file is added to the
#     diff pathspec directly, exactly like a code glob — git diff sees both.
#   - cross-repo mode (source_repo configured): the doc's git history lives in a
#     DIFFERENT repo than <anchor-field>..HEAD, so it cannot be diffed against
#     that range at all. Instead, this script sha256-hashes the doc's current
#     content and compares it to the feature's stored `doc_content_hash` in
#     inventory.json — a mismatch is reported the same as a code diff (added to
#     `changed`), and callers (Audit mode) are expected to update
#     `doc_content_hash` when they commit state, the same way they update the
#     anchor commit.
#
# Fail-safe rule: any anchor that can't be resolved/diffed cleanly is treated as
# CHANGED, never as unchanged. A rebase, squash-merge, or shallow clone must push
# a feature toward re-analysis, not toward a silent auto-pass.
#
# Noise filter: common lockfiles are excluded from the diff pathspec entirely, and
# whatever diff remains is rechecked ignoring whitespace/blank-line-only changes.
# A feature whose only drift is a lockfile bump or a reformat is UNCHANGED, not
# flagged for a full re-analysis — a real change alongside noise still flags it,
# since the exclusion only removes lockfile paths, not the rest of the diff.
#
# Output (stdout): JSON
# {
#   "changed":       ["<feature-id>", ...],
#   "unchanged":     ["<feature-id>", ...],
#   "anchor_errors": ["<feature-id>", ...],   // subset of changed; anchor unusable
#   "no_globs":      ["<feature-id>", ...],   // subset of changed; nothing to diff against
#   "doc_hash_changed": ["<feature-id>", ...], // subset of changed; cross-repo mode only
#   "new_paths":      ["<path>", ...]          // changed files matching no known glob
# }
set -o pipefail

LOCKFILE_PATTERNS=(
  "**/package-lock.json"
  "**/yarn.lock"
  "**/pnpm-lock.yaml"
  "**/Gemfile.lock"
  "**/composer.lock"
  "**/poetry.lock"
  "**/Cargo.lock"
  "**/go.sum"
  "**/Pipfile.lock"
  "**/mix.lock"
)
lockfile_excludes=()
for p in "${LOCKFILE_PATTERNS[@]}"; do
  lockfile_excludes+=(":(exclude,glob)$p")
done

usage() { echo "usage: $0 <anchor-field> [--include-doc]" >&2; exit 2; }

ANCHOR_FIELD="${1:-}"
INCLUDE_DOC=false
[ -n "${2:-}" ] && [ "$2" = "--include-doc" ] && INCLUDE_DOC=true
[ -z "$ANCHOR_FIELD" ] && usage

DOCS_ROOT="$PWD"
while [ "$DOCS_ROOT" != "/" ] && [ ! -f "$DOCS_ROOT/.ai/metadata/inventory.json" ]; do
  DOCS_ROOT="$(dirname "$DOCS_ROOT")"
done
[ -f "$DOCS_ROOT/.ai/metadata/inventory.json" ] || { echo '{"error":"no .ai/metadata/inventory.json found in this or any parent directory"}' >&2; exit 1; }
cd "$DOCS_ROOT" || exit 1
INV=".ai/metadata/inventory.json"

PROJECT_CFG=".ai/metadata/project.json"
SOURCE_REPO="$DOCS_ROOT"
CROSS_REPO=false
if [ -f "$PROJECT_CFG" ]; then
  cfg_source=$(jq -r '.source_repo // empty' "$PROJECT_CFG")
  if [ -n "$cfg_source" ]; then
    case "$cfg_source" in
      /*) SOURCE_REPO="$cfg_source" ;;
      *) SOURCE_REPO="$DOCS_ROOT/$cfg_source" ;;
    esac
    SOURCE_REPO="$(cd "$SOURCE_REPO" 2>/dev/null && pwd)" || { echo "{\"error\":\"source_repo path not found: $cfg_source\"}" >&2; exit 1; }
    CROSS_REPO=true
  fi
fi

hash_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

changed=()
unchanged=()
anchor_errors=()
no_globs=()
doc_hash_changed=()
all_globs_seen=()

feature_count=$(jq '.features | length' "$INV")

for i in $(seq 0 $((feature_count - 1))); do
  feature=$(jq -c ".features[$i]" "$INV")
  id=$(echo "$feature" | jq -r '.id')
  status=$(echo "$feature" | jq -r '.status')
  anchor=$(echo "$feature" | jq -r --arg f "$ANCHOR_FIELD" '.[$f] // "null"')

  if [ "$anchor" = "null" ] || [ "$status" = "skipped" ] || [ "$status" = "pending" ]; then
    continue
  fi

  globs=()
  while IFS= read -r line; do
    [ -n "$line" ] && globs+=("$line")
  done < <(echo "$feature" | jq -r '.files[]? // empty')

  while IFS= read -r line; do
    [ -n "$line" ] && globs+=("$line")
  done < <(jq -r --arg fid "$id" \
    '.shared_modules[]? | select(.used_by // [] | index($fid)) | .files[]? // empty' "$INV")

  doc_drifted=false
  if [ "$INCLUDE_DOC" = true ]; then
    doc=$(echo "$feature" | jq -r '.doc // empty')
    if [ -n "$doc" ]; then
      if [ "$CROSS_REPO" = true ]; then
        if [ -f "$doc" ]; then
          current_hash=$(hash_file "$doc")
          stored_hash=$(echo "$feature" | jq -r '.doc_content_hash // empty')
          [ -n "$stored_hash" ] && [ "$current_hash" != "$stored_hash" ] && doc_drifted=true
          [ -z "$stored_hash" ] && doc_drifted=true
        fi
      else
        globs+=("$doc")
      fi
    fi
  fi

  all_globs_seen+=("${globs[@]}")

  if [ ${#globs[@]} -eq 0 ] && [ "$doc_drifted" = false ]; then
    no_globs+=("$id")
    changed+=("$id")
    continue
  fi

  if [ "$doc_drifted" = true ]; then
    doc_hash_changed+=("$id")
    changed+=("$id")
    continue
  fi

  # Anchor reachability check: fail toward re-analysis, never toward auto-pass.
  # Note: this only catches a PRUNED/missing commit object (shallow clone, gc'd
  # history) — a dangling-but-still-present object from an in-flight rewrite
  # would pass this check. `git diff` still produces a correct tree diff against
  # it either way, so this is a narrow, accepted gap, not a silent-pass bug.
  if ! git -C "$SOURCE_REPO" cat-file -e "${anchor}^{commit}" 2>/dev/null; then
    anchor_errors+=("$id")
    changed+=("$id")
    continue
  fi

  set +e
  git -C "$SOURCE_REPO" diff --quiet --ignore-all-space --ignore-blank-lines "${anchor}..HEAD" -- "${globs[@]}" "${lockfile_excludes[@]}" 2>/dev/null
  rc=$?
  set -e

  if [ "$rc" -eq 0 ]; then
    unchanged+=("$id")
  elif [ "$rc" -eq 1 ]; then
    changed+=("$id")
  else
    # rc > 1: git errored (bad pathspec, unresolvable range, etc.) — flag it.
    anchor_errors+=("$id")
    changed+=("$id")
  fi
done

# Best-effort "new/unclaimed code" detection: changed files since the OLDEST anchor
# across all processed features, that don't match any known feature/shared-module glob.
oldest_anchor=$(jq -r --arg f "$ANCHOR_FIELD" \
  '[.features[] | select(.[$f] != null and .status != "skipped" and .status != "pending") | .[$f]] | .[0] // empty' "$INV")

new_paths=()
if [ -n "$oldest_anchor" ] && git -C "$SOURCE_REPO" cat-file -e "${oldest_anchor}^{commit}" 2>/dev/null; then
  all_changed_files=$(git -C "$SOURCE_REPO" diff --name-only "${oldest_anchor}..HEAD" 2>/dev/null || true)
  if [ -n "$all_changed_files" ]; then
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      matched=false
      for g in "${all_globs_seen[@]}"; do
        [ -z "$g" ] && continue
        case "$f" in
          $g) matched=true; break ;;
        esac
      done
      [ "$matched" = false ] && new_paths+=("$f")
    done <<< "$all_changed_files"
  fi
fi

to_json_array() {
  if [ "$#" -eq 0 ]; then echo "[]"; return; fi
  printf '%s\n' "$@" | jq -R . | jq -s .
}

jq -n \
  --argjson changed "$(to_json_array "${changed[@]}")" \
  --argjson unchanged "$(to_json_array "${unchanged[@]}")" \
  --argjson anchor_errors "$(to_json_array "${anchor_errors[@]}")" \
  --argjson no_globs "$(to_json_array "${no_globs[@]}")" \
  --argjson doc_hash_changed "$(to_json_array "${doc_hash_changed[@]}")" \
  --argjson new_paths "$(to_json_array "${new_paths[@]}")" \
  '{changed: $changed, unchanged: $unchanged, anchor_errors: $anchor_errors, no_globs: $no_globs, doc_hash_changed: $doc_hash_changed, new_paths: $new_paths}'
