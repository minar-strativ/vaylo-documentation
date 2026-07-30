# Writing Rules

## Audience declaration (project-configurable — edit at adoption time)

```yaml
primary_reader: client        # exactly ONE of: client | qa | product-team
secondary_reader: qa
```

Exactly one primary reader, always. "Written for everyone" is readable by no one. All style decisions below assume the default (client primary, QA secondary); if a project flips the primary, adjust jargon level accordingly, but the structure rules stand.

## Sensitivity denylist (project owner fills in at adoption time)

Topics that must NOT appear in docs (commercial terms, security internals, unreleased plans):

```yaml
denylist: []
# example: ["margin calculations", "fraud detection thresholds"]
```

## Style rules

1. **Business-first, implementation-last.** Describe what happens and why it matters — never how it's coded.
2. **Forbidden in doc bodies:** code identifiers (class/function/variable names), file paths, stack/framework names, database terms (table, column, query), HTTP verbs and status codes, internal jargon.
3. **Exact values, always.** "Cancellation is free up to 48 hours before the appointment" — not "cancellation is possible within a certain window". Vague docs are useless docs.
4. **Examples over abstraction.** Every non-trivial rule gets a concrete example ("A customer booking on Monday for Wednesday can cancel free until Monday...").
5. **Explain behavior including failure.** What the user sees when something is rejected matters as much as the happy path.
6. **Glossary terms only.** Use the exact terms in `glossary.md`. Meet a new business term → add it to the glossary in the same step. One concept, one term, everywhere.
7. **QA detail is welcome but contained** — exact boundaries, edge cases, and error messages go in the "Rules & Edge Cases" section of each doc, not scattered through the prose.
8. **Active voice, present tense, short sentences.** "The system sends a reminder 24 hours before the appointment."

## Cross-references

- Every capability is explained in exactly ONE doc (feature ownership). Elsewhere: one sentence + relative link: `[Payments](payments.md)`.
- Links are always relative within `docs/product/`, always to a file that exists. Deep-link with heading anchors when referencing a specific rule.

## Doc frontmatter (machine-read; keep exact keys)

```yaml
---
feature: booking
status: completed          # or needs_review
updated: 2026-07-19
review_note: ""            # only when needs_review: the exact question a human must answer
---
```
