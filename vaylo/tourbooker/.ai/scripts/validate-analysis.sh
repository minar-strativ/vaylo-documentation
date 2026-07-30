#!/usr/bin/env bash
# validate-analysis.sh [<feature-id>]
#
# Deterministic, zero-token shape check for a feature's `analysis` object
# (see modes/create.md's inventory schema). Run immediately after the
# Analyzer step writes or patches `analysis` (Create B2, Maintain B2, Audit
# A1) — catches malformed extraction before the Writer step, or a later
# Maintain/Audit run, consumes it as if it were valid.
#
# With no argument: checks every feature that has a non-empty `analysis`
# object. With <feature-id>: checks just that feature.
#
# This is a SHAPE check, not a truth check — it doesn't verify facts are
# correct (that's the Analyzer/Audit's job), only that the structure is well
# formed enough for the Writer and other modes to consume safely.
#
# Output (stdout): JSON
# {
#   "invalid": [
#     { "feature": "<id>", "issues": ["missing-key:permissions", "rules[2]: missing evidence", ...] }
#   ]
# }
set -o pipefail

SCOPE_FEATURE="${1:-}"

ROOT="$PWD"
while [ "$ROOT" != "/" ] && [ ! -f "$ROOT/.ai/metadata/inventory.json" ]; do
  ROOT="$(dirname "$ROOT")"
done
[ -f "$ROOT/.ai/metadata/inventory.json" ] || { echo '{"error":"no .ai/metadata/inventory.json found in this or any parent directory"}' >&2; exit 1; }
cd "$ROOT" || exit 1
INV=".ai/metadata/inventory.json"

REQUIRED_CATEGORIES=(workflows rules validations permissions field_meanings journeys side_effects)

jq --arg cats "$(printf '%s\n' "${REQUIRED_CATEGORIES[@]}" | jq -R . | jq -s -c .)" \
   --arg scope "$SCOPE_FEATURE" \
   -f /dev/stdin "$INV" <<'JQ'
($cats | fromjson) as $required
| ($scope) as $scope
| {
    invalid: [
      .features[]
      | select($scope == "" or .id == $scope)
      | select(.analysis != null and (.analysis | length) > 0)
      | . as $f
      | {
          feature: $f.id,
          issues: (
            ($required - ($f.analysis | keys)) as $missing_keys
            | ($missing_keys | map("missing-key:" + .)) as $missing_key_issues
            | (
                $required
                | map(. as $cat
                    | ($f.analysis[$cat] // []) as $entries
                    | if ($entries | type) != "array" then
                        [$cat + ": not an array"]
                      else
                        [
                          range(0; $entries | length) as $i
                          | $entries[$i] as $e
                          | if ($e | type) != "object" then
                              ($cat + "[" + ($i|tostring) + "]: not an object")
                            elif (($e.fact // "") | length) == 0 then
                              ($cat + "[" + ($i|tostring) + "]: missing/empty fact")
                            elif (($e.evidence // "") | length) == 0 then
                              ($cat + "[" + ($i|tostring) + "]: missing/empty evidence")
                            else
                              empty
                            end
                        ]
                      end
                  )
                | flatten
              ) as $entry_issues
            | ($missing_key_issues + $entry_issues)
          )
        }
      | select(.issues | length > 0)
    ]
  }
JQ
