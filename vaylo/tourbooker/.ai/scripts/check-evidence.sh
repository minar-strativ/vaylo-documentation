#!/usr/bin/env bash
# check-evidence.sh
#
# Deterministic, zero-token evidence check used by Audit mode Phase A0 (replaces
# the AI reading every evidence path itself). For every feature, verifies:
#   - every path in `evidence` (section -> [paths]) still exists
#   - every `path:symbol` entry still contains that symbol (grep)
#   - every evidence pointer inside `analysis.<category>[].evidence` still exists
#   - a feature with a status of completed/needs_review but an EMPTY evidence
#     map and an empty/absent analysis object is reported explicitly, never
#     silently treated as "nothing to check" (that would be a false auto-pass).
#
# Multi-repo mode: if .ai/metadata/project.json sets "source_repo", evidence
# paths (which point at code) are resolved against THAT repo, not the repo this
# script itself lives in — same convention as diff-since.sh.
#
# Output (stdout): JSON
# {
#   "broken": [ { "feature": "<id>", "path": "<path>", "reason": "missing-file" | "missing-symbol" } ],
#   "empty_evidence": ["<feature-id>", ...]
# }
set -o pipefail

DOCS_ROOT="$PWD"
while [ "$DOCS_ROOT" != "/" ] && [ ! -f "$DOCS_ROOT/.ai/metadata/inventory.json" ]; do
  DOCS_ROOT="$(dirname "$DOCS_ROOT")"
done
[ -f "$DOCS_ROOT/.ai/metadata/inventory.json" ] || { echo '{"error":"no .ai/metadata/inventory.json found in this or any parent directory"}' >&2; exit 1; }
cd "$DOCS_ROOT" || exit 1
INV=".ai/metadata/inventory.json"

PROJECT_CFG=".ai/metadata/project.json"
SOURCE_REPO="$DOCS_ROOT"
if [ -f "$PROJECT_CFG" ]; then
  cfg_source=$(jq -r '.source_repo // empty' "$PROJECT_CFG")
  if [ -n "$cfg_source" ]; then
    case "$cfg_source" in
      /*) SOURCE_REPO="$cfg_source" ;;
      *) SOURCE_REPO="$DOCS_ROOT/$cfg_source" ;;
    esac
    SOURCE_REPO="$(cd "$SOURCE_REPO" 2>/dev/null && pwd)" || { echo "{\"error\":\"source_repo path not found: $cfg_source\"}" >&2; exit 1; }
  fi
fi

check_one() {
  local feature_id="$1" raw="$2"
  local path="${raw%%:*}"
  local symbol=""
  [ "$raw" != "$path" ] && symbol="${raw#*:}"
  local resolved="$SOURCE_REPO/$path"

  if [ ! -e "$resolved" ]; then
    printf '%s\t%s\t%s\n' "$feature_id" "$path" "missing-file"
    return
  fi
  if [ -n "$symbol" ] && ! grep -q -F -- "$symbol" "$resolved" 2>/dev/null; then
    printf '%s\t%s\t%s\n' "$feature_id" "$raw" "missing-symbol"
  fi
}

broken_rows=""
empty_ids=()

feature_count=$(jq '.features | length' "$INV")

for i in $(seq 0 $((feature_count - 1))); do
  feature=$(jq -c ".features[$i]" "$INV")
  id=$(echo "$feature" | jq -r '.id')
  status=$(echo "$feature" | jq -r '.status')
  [ "$status" != "completed" ] && [ "$status" != "needs_review" ] && continue

  evidence_paths=$(echo "$feature" | jq -r '
    (.evidence // {}) as $e
    | [$e[] | if type=="array" then .[] else . end] as $ev
    | (.analysis // {}) as $a
    | [$a[]? | .[]? | .evidence? // empty] as $av
    | ($ev + $av)[]
  ')

  if [ -z "$evidence_paths" ]; then
    empty_ids+=("$id")
    continue
  fi

  while IFS= read -r raw; do
    [ -z "$raw" ] && continue
    row=$(check_one "$id" "$raw")
    [ -n "$row" ] && broken_rows="${broken_rows}${row}
"
  done <<< "$evidence_paths"
done

to_json_array() {
  if [ "$#" -eq 0 ]; then echo "[]"; return; fi
  printf '%s\n' "$@" | jq -R . | jq -s .
}

broken_json="[]"
if [ -n "$broken_rows" ]; then
  broken_json=$(printf '%s' "$broken_rows" | awk -F'\t' 'NF==3' | \
    jq -R -s '[splits("\n") | select(length > 0) | split("\t") | {feature: .[0], path: .[1], reason: .[2]}]')
fi

jq -n \
  --argjson broken "$broken_json" \
  --argjson empty_evidence "$(to_json_array "${empty_ids[@]}")" \
  '{broken: $broken, empty_evidence: $empty_evidence}'
