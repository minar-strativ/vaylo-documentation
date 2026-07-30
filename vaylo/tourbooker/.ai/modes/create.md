# Create Mode — Generate the Knowledge Base from Scratch

Read first: `rules/analysis.md`, `rules/granularity.md`, `rules/writing.md`, `rules/quality.md`, `templates/feature.md`, `glossary.md`.

## Preconditions

- No inventory exists, OR progress.json shows an unfinished Create run (then skip to the phase/step it names).
- Record the run anchor: `git rev-parse HEAD` → `progress.json.run_anchor_commit`.

## Phase A0 — Scripted repo-manifest pre-pass (mechanical, no AI reasoning)

Before any AI-driven discovery, run a cheap manifest pass so Phase A isn't scanning cold:

```bash
find . -type f \( -name '*.md' -o -path '*/routes/*' -o -path '*/pages/*' -o -path '*/models/*' \) \
  -not -path '*/node_modules/*' -not -path '*/.git/*' | sort
git ls-files | wc -l
```

Use the output as a starting manifest for A1 (candidate entry points, route/page files, model files) instead of an unguided directory walk. Print a one-line preview here: total tracked file count and the manifest's rough size — this is the first of two budget checkpoints (the second is after A6), so a large/monorepo scan can be reconsidered before any AI reasoning is spent on it.

**Model note:** this phase is mechanical — run it under a fast/cheap model where your setup supports switching (see `framework.md` §Model tiering).

## Phase A — Discovery (NO documentation is written in this phase)

Execute in order. After each step, update progress.json (`current_step`).

**A1. Repository scan.** Map the project per `rules/analysis.md` §Repo-level, using the A0 manifest as a starting point: entry points, routes/pages, domain folders, data models, permission definitions.

**A2. Feature detection.** Produce candidate feature list. Apply `rules/granularity.md` to split/merge candidates.

**A3. Relationship detection.** For each feature: `depends_on` (features it triggers or requires).

**A4. Shared-module detection.** Identify cross-cutting modules (auth, pricing, notifications...). Record `used_by`. A shared module becomes a feature only if it carries business rules (granularity rules apply).

**A5. Existing-docs inventory (brownfield).** Find existing documentation (README sections, `docs/`, wiki exports). Record per feature as `existing_docs: [paths]`. Do not read them in depth yet.

**A6. Write inventory.** Create `metadata/inventory.json` per the schema below. Every feature: `status: pending`. Present the feature list to the user as a short summary (names + one-liners), plus a second budget preview (feature count, rough file count to analyze) before Phase B. If the user asks to exclude a candidate (out of scope, deprecated, internal-only), set its `status: skipped` and record why in `skip_reason` — it is then permanently excluded from Phase B (which only processes `pending` features).

**A7. Plan order.** Order features: foundational/most-depended-on first. Record order in inventory (array order = plan order).

**Model note:** A2–A4 (feature detection, granularity judgment, shared-module classification) require business judgment — use your default/strong model here, not the cheap tier from A0.

### inventory.json schema

```json
{
  "generated_at": "<ISO timestamp>",
  "anchor_commit": "<sha>",
  "features": [
    {
      "id": "<kebab-slug>",
      "name": "<Business name>",
      "summary": "<one line>",
      "files": ["<glob>", "..."],
      "depends_on": ["<feature-id>"],
      "shared_modules": ["<module-id>"],
      "existing_docs": ["<path>"],
      "status": "pending",
      "skip_reason": null,
      "doc": "docs/product/<slug>.md",
      "documented_at_commit": null,
      "audited_at_commit": null,
      "full_audits_skipped": 0,
      "evidence": {},
      "analysis": {
        "workflows": [],
        "rules": [],
        "validations": [],
        "permissions": [],
        "field_meanings": [],
        "journeys": [],
        "side_effects": []
      }
    }
  ],
  "shared_modules": [
    { "id": "<slug>", "files": ["<glob>"], "used_by": ["<feature-id>"] }
  ]
}
```

`status` values: `pending → in_progress → completed | needs_review`, or `skipped` (set at A6 or later, permanently excluded from Phase B).

`audited_at_commit` starts `null` and is only ever written by Audit mode (`modes/audit.md`) — it tracks the last commit a feature was either auto-passed or fully re-checked against, independent of `documented_at_commit`.

`full_audits_skipped` starts `0` and is only ever written by Audit mode — it counts consecutive auto-passes since the last full truth audit, and forces a full re-check once it hits the threshold in `modes/audit.md`, so a change via an untracked dependency (not covered by any registered glob/shared_module) can't let a feature auto-pass forever.

`analysis` is the Analyzer step's persisted output (see Phase B2 below): structured facts per `rules/analysis.md`'s 7 questions, NOT prose. Each entry in every array is an object `{ "fact": "<one business fact>", "evidence": "<path>" or "<path>:<symbol>" }`. This is what Maintain and Audit modes read/patch instead of re-deriving behavior from raw code — the doc body (written by the Writer step) and the `evidence` map (doc-section → paths) are both derived FROM `analysis`, not the other way around.

## Phase B — Documentation loop (one feature at a time)

**Run cap.** Before starting, set `run_processed_count = 0` in progress.json `notes`. This mode processes at most `max_features_per_run` (default 15) features per invocation — after each feature completes B6, increment the counter; if it reaches the cap, stop cleanly (progress.json already points at the next `pending` feature, so this is a normal resume point, not a broken state) and report "`N` features remaining, re-run `/doc-create` to continue." This bounds worst-case spend per invocation regardless of how many other optimizations below apply.

For the next feature in plan order with `status: pending` (and under the run cap):

**B1. Claim.** Set feature `status: in_progress`; progress.json `current_feature`, `current_step: analyze`.

**B2. Analyze (Analyzer step).** Follow `rules/analysis.md` §Feature-level. Read the feature's code and answer its 7 questions. Write the result as the feature's `analysis` object in inventory.json — structured facts with evidence pointers, not prose (see schema above). This is a mechanical extraction step: candidate for a cheap/fast model where your setup supports switching mid-run (see `framework.md` §Model tiering). Then run `.ai/scripts/validate-analysis.sh <feature-id>` — if it reports any `issues`, fix the `analysis` object before moving to B3/B4; don't let a malformed fact reach the Writer step.

**B3. Brownfield import (only if `existing_docs` is non-empty).** Read each existing doc. Treat every statement as an *unverified claim*: verify against code → fold into the `analysis` object (with evidence); unverifiable but looks like intent → note for `needs_review`; wrong → discard. Add changelog line `superseded-by` for each imported source. Never delete existing files.

**B4. Generate (Writer step).** Read ONLY the feature's `analysis` object — do not re-read the source code. Write `docs/product/<slug>.md` from `templates/feature.md`, turning facts into client-facing prose per `rules/writing.md`. Set `current_step: generate` before starting; if the doc is long, save partial file and note resume point in progress.json `notes`. This step needs business judgment and prose quality — use your default/strong model, not the Analyzer's cheap tier.

**B5. Self-review.** First run `.ai/scripts/lint-docs.sh docs/product/<slug>.md` — scoped to just this doc, mechanical only (frontmatter validity, broken links, code-fence-aware link checking). Fix anything it flags before doing anything else. Then apply the rest of the checklist in `rules/quality.md` (the parts a script can't judge: does each section actually answer its question, terminology vs. glossary, duplication against other docs). Fix what you can. Anything unresolvable from code alone → set `status: needs_review` and add a frontmatter `review_note:` in the doc stating exactly what a human must decide. Otherwise → proceed.

**B6. Commit state.** In inventory: `evidence` map (section → paths, derived from `analysis`), `documented_at_commit: <git rev-parse HEAD>`, `status: completed` (or `needs_review`). Append changelog line. Update `docs/product/index.md` (create if missing: title + one-line + link per feature, grouped sensibly). Increment `run_processed_count`.

**B7. Next.** Reset progress.json to the next pending feature. Repeat (respecting the run cap above).

## Completion

When no `pending` features remain: write final changelog line `create run completed`, clear progress.json to `{"mode": "idle"}`, and report to the user: features documented, features in `needs_review` (with their questions), features `skipped` (with their `skip_reason`).
