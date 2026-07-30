# Analysis Rules

Two zoom levels. Repo-level runs once per Create run; feature-level runs once per feature.

## Repo-level discovery

Goal: find every business capability. You are looking for what the product DOES, not how the code is organized.

Look at, in order of signal strength:

1. **Routes / pages / screens** — each user-facing surface belongs to some feature.
2. **Domain folders / modules** — `booking/`, `payments/`, `apps/*`.
3. **Data models / migrations** — each core entity is owned by some feature.
4. **Permission / role definitions** — reveal actors and protected capabilities.
5. **Background jobs, scheduled tasks, webhooks** — invisible features live here (reminders, syncs, cleanup).
6. **External integrations** — payment providers, email/SMS, third-party APIs.

Output: candidate features (apply `rules/granularity.md`), their file globs, dependencies, shared modules.

Anti-patterns: do NOT create features from technical layers ("controllers", "API", "database"), and do NOT skip admin/internal capabilities — back-office is product too.

## Feature-level analysis

For one feature, answer these seven questions by READING ITS CODE (not guessing). For each answer, record the file/symbol you derived it from.

This is the Analyzer step (`modes/create.md` Phase B2, `modes/maintain.md` Phase B2, `modes/audit.md` Phase A1): its output is the feature's persisted `analysis` object in `inventory.json` — one entry per fact, each `{ "fact": "...", "evidence": "<path>" or "<path>:<symbol>" }`, NOT prose. The Writer step (Create B4, Maintain B4) reads only this object to produce the doc; it does not re-read the source code. Maintain and Audit re-run this step scoped to a diff and PATCH the existing `analysis` object rather than regenerating it whole — this is what makes those modes cheap. The doc's `evidence` map (section → paths) is a derived index over `analysis`, not a separate thing to track by hand.

1. **Workflows** — what sequences of actions can happen? Trace each from trigger (user action, schedule, webhook) to outcome. Include failure paths.
2. **Business rules** — conditions that change outcomes: limits, windows, thresholds, calculations, state transitions. Extract exact values (fees, durations, counts) — vague docs are useless docs.
3. **Validations** — what input is rejected and with what message. Boundaries matter (min/max, formats, uniqueness).
4. **Permissions** — who can do what. Map every action to roles/conditions.
5. **Field meanings** — for user-visible fields: business meaning, not column type. What does `status = 3` mean to a human?
6. **User journeys** — how a real person experiences the feature end-to-end, including notifications they receive.
7. **Side effects on other features** — what this feature triggers elsewhere (events, emails, invoice creation). These become cross-references, not duplicated explanations.

## Targeted reads for large files

Before reading a file, check its size (`wc -l`). Under a few hundred lines, just read it whole — the overhead of targeting isn't worth it. Over that, don't read the whole file: `grep -n` for the symbols, routes, or rule names likely relevant (informed by the feature's name/summary and any existing evidence paths pointing into that file), then read only those line ranges (`Read` with `offset`/`limit` around each hit, with a little padding for context). This matters most in monorepos and large domain files; small features in small files never need it.

## Evidence discipline

- A statement you cannot point to code for does not go in the doc. Flag it in `review_note:` instead.
- Evidence map granularity: one entry per doc section, listing the paths (optionally `path:symbol`) that support it.
- Evidence lives ONLY in `metadata/inventory.json` — never in doc bodies.

## Large features / context limits

If a feature is too large to analyze in one pass: analyze one workflow at a time, write partial doc sections as you finish them, and record the resume point in progress.json `notes`. Never hold analysis "in your head" across a session boundary.
