#!/usr/bin/env bash
# lint-docs.sh [<doc-path>]
#
# Deterministic, zero-token half of the Audit-mode quality validator
# (rules/quality.md §Validator). Only checks that are actually reliable as a
# script run here; anything requiring semantic judgment (terminology drift,
# duplicated business knowledge across docs) is left to the AI on purpose.
#
# With no argument: whole-KB run (used by Audit Phase B) — all checks below.
# With <doc-path>: scoped run (used by Create/Maintain's B5 self-review right
# after writing/updating that one doc) — only the per-doc checks (frontmatter,
# links) run against that file; the whole-KB checks (missing_doc, orphan_doc,
# index_missing) are skipped since they're meaningless for a single doc and
# would require scanning everything, defeating the point of a scoped call.
#
# Output (stdout): JSON
# {
#   "broken_frontmatter": [ { "doc": "<path>", "reason": "..." } ],
#   "broken_links":       [ { "doc": "<path>", "link": "<target>", "reason": "missing-file" } ],
#   "unverified_anchors":  [ { "doc": "<path>", "link": "<target>" } ],   // #heading links — file exists, heading not verified here
#   "missing_doc":        ["<feature-id>", ...],                          // completed/needs_review feature, no doc file
#   "orphan_doc":         ["<path>", ...],                                // doc file with no inventory entry
#   "index_missing":      ["<feature-id>", ...]                           // completed feature absent from index.md
# }
set -o pipefail

SCOPE_DOC="${1:-}"

[ -n "$SCOPE_DOC" ] && [ ! -f "$SCOPE_DOC" ] && { echo "{\"error\":\"$SCOPE_DOC not found\"}" >&2; exit 1; }
[ -n "$SCOPE_DOC" ] && SCOPE_DOC="$(cd "$(dirname "$SCOPE_DOC")" && pwd)/$(basename "$SCOPE_DOC")"

ROOT="$PWD"
while [ "$ROOT" != "/" ] && [ ! -f "$ROOT/.ai/metadata/inventory.json" ]; do
  ROOT="$(dirname "$ROOT")"
done
[ -f "$ROOT/.ai/metadata/inventory.json" ] || { echo '{"error":"no .ai/metadata/inventory.json found in this or any parent directory"}' >&2; exit 1; }
cd "$ROOT" || exit 1
INV=".ai/metadata/inventory.json"
DOCS_DIR="docs/product"
[ -n "$SCOPE_DOC" ] && SCOPE_DOC="${SCOPE_DOC#"$ROOT"/}"

PY=$(command -v python3 || command -v python || true)
[ -z "$PY" ] && { echo '{"error":"python3 not found, required for frontmatter parsing"}' >&2; exit 1; }

broken_frontmatter_rows=""
broken_link_rows=""
unverified_anchor_rows=""
missing_doc=()
index_missing=()

feature_count=$(jq '.features | length' "$INV")
orphan_docs=()

if [ -z "$SCOPE_DOC" ]; then
  # --- missing_doc: completed/needs_review feature with no doc file on disk ---
  for i in $(seq 0 $((feature_count - 1))); do
    feature=$(jq -c ".features[$i]" "$INV")
    id=$(echo "$feature" | jq -r '.id')
    status=$(echo "$feature" | jq -r '.status')
    doc=$(echo "$feature" | jq -r '.doc // empty')
    if { [ "$status" = "completed" ] || [ "$status" = "needs_review" ]; } && { [ -z "$doc" ] || [ ! -f "$doc" ]; }; then
      missing_doc+=("$id")
    fi
  done

  # --- orphan_doc: doc file on disk with no matching inventory entry ---
  if [ -d "$DOCS_DIR" ]; then
    known_docs=$(jq -r '.features[].doc // empty' "$INV")
    while IFS= read -r f; do
      [ -z "$f" ] && continue
      [ "$(basename "$f")" = "index.md" ] && continue
      [[ "$(basename "$f")" == audit-*.md ]] && continue
      if ! grep -qxF "$f" <<< "$known_docs"; then
        orphan_docs+=("$f")
      fi
    done < <(find "$DOCS_DIR" -maxdepth 1 -name '*.md' 2>/dev/null)
  fi

  # --- index_missing: completed feature absent from index.md ---
  if [ -f "$DOCS_DIR/index.md" ]; then
    for i in $(seq 0 $((feature_count - 1))); do
      feature=$(jq -c ".features[$i]" "$INV")
      id=$(echo "$feature" | jq -r '.id')
      status=$(echo "$feature" | jq -r '.status')
      doc=$(echo "$feature" | jq -r '.doc // empty')
      [ "$status" != "completed" ] && continue
      [ -z "$doc" ] && continue
      docbase=$(basename "$doc")
      grep -q -F "$docbase" "$DOCS_DIR/index.md" || index_missing+=("$id")
    done
  fi
fi

# --- per-doc checks: frontmatter validity, cross-reference links (code-fence-aware) ---
# Scoped run: just SCOPE_DOC. Whole-KB run: every doc under DOCS_DIR.
if [ -n "$SCOPE_DOC" ]; then
  doc_source() { printf '%s\n' "$SCOPE_DOC"; }
else
  doc_source() { find "$DOCS_DIR" -maxdepth 1 -name '*.md' ! -name 'index.md' ! -name 'audit-*.md' 2>/dev/null; }
fi

if [ -n "$SCOPE_DOC" ] || [ -d "$DOCS_DIR" ]; then
  while IFS= read -r doc; do
    [ -z "$doc" ] && continue

    fm_result=$("$PY" - "$doc" <<'PYEOF'
import sys
path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    text = f.read()

lines = text.splitlines()
if not lines or lines[0].strip() != "---":
    print("no-frontmatter-block")
    sys.exit()

end = None
for i in range(1, len(lines)):
    if lines[i].strip() == "---":
        end = i
        break
if end is None:
    print("unterminated-frontmatter-block")
    sys.exit()

required = ["feature", "status", "updated"]
keys = {}
for line in lines[1:end]:
    if not line.strip() or line.strip().startswith("#"):
        continue
    if ":" not in line:
        continue
    k, _, v = line.partition(":")
    keys[k.strip()] = v.strip()

missing = [k for k in required if k not in keys or keys[k] == ""]
if missing:
    print("missing-keys:" + ",".join(missing))
    sys.exit()

if keys.get("status") not in ("completed", "needs_review", "in_progress"):
    print("invalid-status-value:" + keys.get("status", ""))
    sys.exit()

print("ok")
PYEOF
)
    if [ "$fm_result" != "ok" ]; then
      broken_frontmatter_rows="${broken_frontmatter_rows}${doc}\t${fm_result}
"
    fi

    # Strip fenced code blocks before scanning for links, so example links inside
    # ``` fences (illustrating doc syntax) never false-positive as broken.
    links=$("$PY" - "$doc" <<'PYEOF'
import re, sys
bt = chr(96)
path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    text = f.read()
text = re.sub(bt * 3 + r".*?" + bt * 3, "", text, flags=re.DOTALL)
text = re.sub(bt + r"[^" + bt + r"\n]*" + bt, "", text)
for m in re.finditer(r"\[[^\]]*\]\(([^)]+)\)", text):
    target = m.group(1).strip()
    if target.startswith(("http://", "https://", "mailto:")):
        continue
    print(target)
PYEOF
)
    docdir=$(dirname "$doc")
    while IFS= read -r target; do
      [ -z "$target" ] && continue
      filepart="${target%%#*}"
      anchor=""
      [[ "$target" == *"#"* ]] && anchor="${target#*#}"

      if [ -z "$filepart" ]; then
        resolved="$doc"  # bare "#heading" link — same file, already a full path
      else
        resolved="$docdir/$filepart"
      fi
      if [ ! -f "$resolved" ]; then
        broken_link_rows="${broken_link_rows}${doc}\t${target}\tmissing-file
"
      elif [ -n "$anchor" ]; then
        # File exists; heading-slug matching isn't reliable via script — flag for AI to confirm.
        unverified_anchor_rows="${unverified_anchor_rows}${doc}\t${target}
"
      fi
    done <<< "$links"
  done < <(doc_source)
fi

rows_to_json() {
  # $1 = tab-separated rows (2 or 3 cols), $2 = field names comma-separated
  local rows="$1"
  IFS=',' read -ra fields <<< "$2"
  if [ -z "$rows" ]; then echo "[]"; return; fi
  local jq_obj=""
  for idx in "${!fields[@]}"; do
    jq_obj="${jq_obj}${fields[$idx]}: .[$idx], "
  done
  jq_obj="{${jq_obj%, }}"
  printf '%b' "$rows" | awk 'NF' | jq -R -s --arg expr "$jq_obj" \
    '[splits("\n") | select(length > 0) | split("\t")] | map( . as $r | ($r) )' | \
    jq --argjson fieldnames "$(printf '%s\n' "${fields[@]}" | jq -R . | jq -s .)" \
    'map(. as $r | reduce range(0; ($fieldnames|length)) as $i ({}; . + {($fieldnames[$i]): $r[$i]}))'
}

broken_frontmatter_json=$(rows_to_json "$broken_frontmatter_rows" "doc,reason")
broken_links_json=$(rows_to_json "$broken_link_rows" "doc,link,reason")
unverified_anchors_json=$(rows_to_json "$unverified_anchor_rows" "doc,link")

to_json_array() {
  if [ "$#" -eq 0 ]; then echo "[]"; return; fi
  printf '%s\n' "$@" | jq -R . | jq -s .
}

jq -n \
  --argjson broken_frontmatter "$broken_frontmatter_json" \
  --argjson broken_links "$broken_links_json" \
  --argjson unverified_anchors "$unverified_anchors_json" \
  --argjson missing_doc "$(to_json_array "${missing_doc[@]}")" \
  --argjson orphan_doc "$(to_json_array "${orphan_docs[@]}")" \
  --argjson index_missing "$(to_json_array "${index_missing[@]}")" \
  '{broken_frontmatter: $broken_frontmatter, broken_links: $broken_links, unverified_anchors: $unverified_anchors, missing_doc: $missing_doc, orphan_doc: $orphan_doc, index_missing: $index_missing}'
