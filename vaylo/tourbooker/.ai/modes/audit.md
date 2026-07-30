# Audit Mode — Validate Docs Against Reality

Read first: `rules/quality.md`, `rules/writing.md`, `rules/analysis.md`, `glossary.md`.

Audit has three layers, run in this order:

- **Phase A0** — scripted gate (mechanical, zero AI reads): which features can auto-pass, which must be fully re-checked
- **Phase A** — truth audit (AI-driven, flagged features only): does stored `analysis` + the doc still match current code?
- **Phase B** — quality validation (docs vs. themselves): structure, links, terminology, duplication

Audit never edits docs directly. It produces a findings report; fixes are applied afterwards (optionally) via the Maintain pipeline.

## Phase A0 — Scripted gate (mechanical, no AI reasoning)

For every `completed`/`needs_review` feature, run:

```bash
.ai/scripts/diff-since.sh audited_at_commit --include-doc
.ai/scripts/check-evidence.sh
```

A feature **auto-passes** (writes a one-line report entry, bumps `audited_at_commit` to HEAD, resets `full_audits_skipped` toward the next check — see below — and is otherwise untouched: zero code read, zero LLM reasoning spent) only if ALL of:

1. It's in `diff-since.sh`'s `unchanged` list (no code diff, no doc diff since last audit — `--include-doc` means hand-edited docs are caught, not silently trusted forever).
2. It has no entries in `check-evidence.sh`'s `broken` or `empty_evidence` output.
3. Its `full_audits_skipped` counter is below the periodic threshold (default 5).

If (1) or (2) fail: increment nothing, feature goes to Phase A flagged for a full re-check, `full_audits_skipped` resets to `0` after that full check runs.

If (3) fails (the feature has auto-passed 5 times in a row with no detected drift): force it into Phase A anyway, even though A0 found nothing. **Why:** a change routed through a dependency not registered in any `files` glob or `shared_module` — a genuinely untracked coupling — produces no diff and would otherwise let a feature auto-pass forever. This periodic forced check is the safety net for that blind spot; it does not replace fixing the underlying glob/shared_module registration if you find one missing.

Report each auto-passed feature as a single line in the findings report (Phase C); do not write a full drift write-up for it.

**Model note:** A0 is pure script output — no AI reasoning at all for this phase.

## Phase A — Truth audit (AI-driven, only for features Phase A0 flagged)

For each flagged feature, one at a time (track position in progress.json):

**A1. Scoped re-analysis (Analyzer step).** Re-run the Analyzer (per `rules/analysis.md` §Feature-level) scoped to what actually changed — the diff since `audited_at_commit` for code drift, or a full re-derivation only if `check-evidence.sh` reported the feature's evidence/analysis as broken/empty. Patch the feature's stored `analysis` object (see `modes/create.md` schema) rather than starting from a blank slate. Run `.ai/scripts/validate-analysis.sh <feature-id>` and fix any reported issues before A2 — this also catches drift-induced corruption of stored facts that `check-evidence.sh`'s existence checks alone wouldn't (e.g. a patch that leaves an entry's `evidence` field empty).

**A2. Compare against the doc.** Read the doc, compare against the now-current `analysis`. Classify each mismatch:

| Severity | Meaning |
|---|---|
| `missing` | Behavior exists in `analysis`/code, absent from doc |
| `outdated` | Doc states behavior the code no longer has |
| `suspected-bug` | Code contradicts documented *intent* — flag, never "fix" the doc |
| `quality` | Doc is right but violates quality rules |

**A3. Commit state.** Update `audited_at_commit: <HEAD sha>`, reset `full_audits_skipped: 0`. Record findings for Phase C.

**Model note:** this phase needs judgment — use your default/strong model, not A0's script-only tier.

## Phase B — Quality validation (whole KB)

Run the scripted half first:

```bash
.ai/scripts/lint-docs.sh
```

This covers frontmatter validity, `completed`/`needs_review` features missing a doc file (or vice versa), broken cross-reference file targets, and `index.md` completeness — all mechanically. Its `unverified_anchors` output (a link's target file exists but the `#heading` slug isn't script-verifiable) needs one quick AI confirmation per entry, not a full re-scan.

Only these remaining checks from `rules/quality.md` §Validator need the AI, since they require semantic judgment a script can't make:
- Term used that conflicts with or bypasses the glossary
- Same business rule explained in two docs (duplication)
- Doc fails to answer one of the 10 completeness questions in a way that reads as complete (the script only checks structural presence, not whether the content actually answers the question)

## Phase C — Report

Write `docs/product/audit-<YYYY-MM-DD>.md`:

```markdown
# Documentation Audit — <date>
Anchor: <HEAD sha> | Features audited: N | Auto-passed: M | Findings: N

## Auto-passed (no drift detected, verified by script)
- booking — unchanged since <sha>
- payments — unchanged since <sha>

## Findings
| # | Feature | Severity | Finding | Evidence |
|---|---------|----------|---------|----------|
| 1 | booking | outdated | Doc says cancellation allowed up to 24h; code enforces 48h | src/booking/rules.ts:cancelWindow |

## Suspected bugs (needs human decision)
...

## Summary
<3–5 lines: overall drift level, worst areas, recommended action>
```

Append changelog line `audited | <n> findings, <m> auto-passed | <sha>`.

## Phase D — Optional fixes

Only if the user asks: apply `missing` and `outdated` fixes by running the affected features through Maintain Mode Phase B. `suspected-bug` findings are NEVER auto-fixed — they require a human decision (bug fix vs. intent change).
