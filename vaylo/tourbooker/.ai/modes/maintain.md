# Maintenance Mode — Update Docs After Code Changes

Read first: `rules/analysis.md`, `rules/granularity.md`, `rules/writing.md`, `rules/quality.md`.

## Preconditions

- Inventory exists with at least one `completed` feature. If not → Create Mode.
- Working tree is a git repo with history reaching the recorded anchors.

## Phase A — Impact analysis (scripted, mechanical — NO docs are edited in this phase)

**A1.** Run the scripted diff gate instead of manually running/interpreting `git diff` yourself:

```bash
.ai/scripts/diff-since.sh documented_at_commit
```

This diffs each `completed`/`needs_review` feature's `files` globs — plus any `shared_modules` that list it in `used_by` (the fan-out) — against its `documented_at_commit`, and fails toward `changed` (never toward a silent pass) if an anchor is unreachable or the diff errors. Its `changed` array is this phase's `affected` list; its `new_paths` array is the input to A3.

**A2. Shared-module fan-out** is already handled by the script above (it includes `shared_modules.used_by` in each feature's diff globs) — no separate manual step needed.

**A3. New code detection.** For each path in the script's `new_paths` output, judge whether it's a candidate new feature or scope growth of an existing one (this judgment call needs the AI — the script can't tell "unclaimed" from "genuinely new business capability"). Apply `rules/granularity.md`: either extend an existing feature's `files` or add a new `pending` feature to inventory.

**A4. Write the impact list** to progress.json:
```json
{
  "mode": "maintain",
  "run_anchor_commit": "<HEAD sha>",
  "affected": ["booking", "invoice"],
  "new_features": ["gift-cards"],
  "current_feature": null,
  "current_step": "update"
}
```
Present the impact list to the user in 2–3 lines before Phase B.

**Model note:** A1/A2 are pure script output — no AI reasoning needed at all. A3 needs judgment — use your default/strong model.

## Phase B — Update loop (one feature at a time)

**Run cap.** Same `max_features_per_run` (default 15) cap as Create mode's Phase B — track `run_processed_count` in progress.json `notes`, stop cleanly and report remaining count if hit. `affected` already tracks what's left, so this is a clean resume point.

For each feature in `affected` (under the run cap):

**B1.** Set `current_feature`; feature `status: in_progress`.

**B2. Scoped re-analysis (Analyzer step, diff-scoped).** Read the diff for this feature's files (`git diff <anchor>..HEAD -- <paths>`), then read only the current code of the changed areas. Update the feature's `analysis` object (see `modes/create.md`'s schema) by patching just the facts the diff invalidates or adds — do NOT re-derive the whole feature's `analysis` from scratch. This is closer to mechanical extraction — candidate for a cheap/fast model where your setup supports switching. Then run `.ai/scripts/validate-analysis.sh <feature-id>` and fix any reported issues before B3.

**B3. Compare.** Read the existing doc. Identify statements the updated `analysis` invalidates, new facts the doc lacks, and evidence paths that moved.

**B4. Surgical update (Writer step).** Edit only affected doc sections, reading from the updated `analysis` object rather than raw code. Preserve wording elsewhere. Update the `evidence` map for changed sections. This step needs judgment/prose quality — use your default/strong model.

**B5. Self-review.** First run `.ai/scripts/lint-docs.sh <doc-path>` — scoped to just this doc — and fix anything it flags. Then the rest of `rules/quality.md` (changed sections + doc-level checks a script can't judge: terminology, duplication). Unresolvable intent questions → `needs_review` + `review_note:`.

**B6. Commit state.** Inventory: new `documented_at_commit: <HEAD sha>`, `status: completed`. Changelog line: `updated | <reason, one line> | <sha>`. Remove feature from `affected` in progress.json. Increment `run_processed_count`.

New features found in A3 are documented afterwards via the Create Mode Phase B loop.

## Completion

`affected` empty and no new pending features → changelog line `maintenance run completed`, progress.json → `{"mode": "idle"}`, report: features updated (with one-line reasons), anything in `needs_review`.
