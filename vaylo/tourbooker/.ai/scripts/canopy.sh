#!/usr/bin/env bash
# canopy.sh — status/dispatch helper for the Canopy doc-maintenance framework.
#
# This is deliberately NOT a full pipeline runner: Create/Maintain/Audit modes
# need AI judgment (deciding what's a new feature, writing prose, resolving
# needs_review) that a script can't do. This script only answers "what state
# is Canopy in, and what should I ask the AI to do next" — the mechanical
# parts (diff-since.sh, validate-analysis.sh, lint-docs.sh) still run as
# documented in modes/*.md.
#
# Usage: .ai/scripts/canopy.sh [status]   (status is the only/default command)
set -o pipefail

DOCS_ROOT="$PWD"
while [ "$DOCS_ROOT" != "/" ] && [ ! -f "$DOCS_ROOT/.ai/metadata/inventory.json" ]; do
  DOCS_ROOT="$(dirname "$DOCS_ROOT")"
done
[ -f "$DOCS_ROOT/.ai/metadata/inventory.json" ] || {
  echo "error: no .ai/metadata/inventory.json found in this or any parent directory" >&2
  exit 1
}
cd "$DOCS_ROOT" || exit 1

INV=".ai/metadata/inventory.json"
PROGRESS=".ai/metadata/progress.json"
PROJECT_CFG=".ai/metadata/project.json"

mode=$(jq -r '.mode' "$PROGRESS")
total=$(jq '.features | length' "$INV")
completed=$(jq '[.features[] | select(.status=="completed")] | length' "$INV")
pending=$(jq '[.features[] | select(.status=="pending")] | length' "$INV")
needs_review=$(jq -r '.features[] | select(.status=="needs_review") | .id' "$INV")
skipped=$(jq '[.features[] | select(.status=="skipped")] | length' "$INV")

echo "Canopy status — $DOCS_ROOT"
echo "  inventory: $total features ($completed completed, $pending pending, $skipped skipped)"
if [ -n "$needs_review" ]; then
  echo "  needs_review:"
  echo "$needs_review" | sed 's/^/    - /'
fi
echo "  mode: $mode"

case "$mode" in
  idle)
    if [ "$pending" -gt 0 ]; then
      echo "  → $pending feature(s) pending — run Create Mode."
    else
      echo "  → checking for code drift since each feature's last documented commit..."
      diff_out=$(.ai/scripts/diff-since.sh documented_at_commit 2>&1)
      if [ $? -ne 0 ]; then
        echo "  ! diff-since.sh failed:" >&2
        echo "$diff_out" >&2
        exit 1
      fi
      changed_count=$(echo "$diff_out" | jq '.changed | length')
      new_paths_count=$(echo "$diff_out" | jq '.new_paths | length')
      if [ "$changed_count" -eq 0 ] && [ "$new_paths_count" -eq 0 ]; then
        echo "  → up to date. Nothing to maintain."
      else
        echo "  → $changed_count feature(s) changed, $new_paths_count unclaimed path(s) — run Maintain Mode."
        echo "$diff_out" | jq -r '.changed[]? | "      changed: " + .'
        echo "$diff_out" | jq -r '.new_paths[]? | "      new path: " + .'
      fi
    fi
    ;;
  create)
    current=$(jq -r '.current_feature // "none"' "$PROGRESS")
    echo "  → Create Mode in progress, current_feature: $current — resume Create Mode Phase B."
    ;;
  maintain)
    affected=$(jq -r '.affected[]?' "$PROGRESS")
    current=$(jq -r '.current_feature // "none"' "$PROGRESS")
    processed=$(jq -r '.notes.run_processed_count // 0' "$PROGRESS")
    echo "  → Maintain Mode in progress ($processed processed), current_feature: $current"
    echo "  → remaining affected:"
    [ -n "$affected" ] && echo "$affected" | sed 's/^/      - /' || echo "      (none)"
    echo "  → resume Maintain Mode Phase B."
    ;;
  audit)
    echo "  → Audit Mode in progress — resume Audit Mode."
    ;;
  *)
    echo "  ! unrecognized mode '$mode' in $PROGRESS" >&2
    exit 1
    ;;
esac

if [ -f "$PROJECT_CFG" ]; then
  src=$(jq -r '.source_repo // empty' "$PROJECT_CFG")
  [ -n "$src" ] && echo "  source_repo: $src"
fi
