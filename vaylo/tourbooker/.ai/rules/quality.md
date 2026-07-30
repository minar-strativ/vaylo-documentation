# Quality Rules

## Self-review checklist (run after EVERY generate or update, before marking completed)

The ten completeness questions — every doc must answer:

1. **What** — what the feature does
2. **Why** — the business purpose it serves
3. **Who** — which roles/actors use it, with permissions
4. **When** — triggers: user actions, schedules, events
5. **How** — the workflows, step by step, as the user experiences them
6. **Rules** — business rules with exact values
7. **Exceptions** — failure paths, edge cases, what the user sees
8. **Limitations** — what it deliberately does not do
9. **Related Features** — cross-references, each one sentence + link
10. **FAQ** — 3–6 questions a client or QA would actually ask

Plus the mechanical checks:

11. Every section has an `evidence` entry in inventory (no evidence → the claim comes out).
12. No forbidden content (see `rules/writing.md` §Style rule 2) and nothing on the denylist.
13. Every term matches `glossary.md`; new terms were added to the glossary.
14. Every cross-reference resolves to an existing file/anchor.
15. No business knowledge duplicated from another doc.
16. Frontmatter present and valid.

**Pass all → `completed`. Fail on anything unresolvable from code alone → `needs_review`** with `review_note:` stating the exact question (e.g., "Code allows negative stock; is this intended oversell support or a bug?"). Never guess to make a check pass.

## Validator checks (Audit Mode, whole-KB)

| Check | Finding severity |
|---|---|
| Doc fails to answer one of the 10 completeness questions (Why/When may be answered inside the opening paragraph or "How it works" rather than a dedicated header — but must still be answered), or a section is empty/boilerplate | `quality` |
| Broken cross-reference (file or anchor) | `quality` |
| Term used that conflicts with or bypasses the glossary | `quality` |
| Same business rule explained in two docs | `quality` |
| Feature in inventory with `status: completed`/`needs_review` but no doc file, or a doc file with no inventory entry (`skipped`/`pending` features are expected to have no doc) | `missing` |
| `index.md` missing a completed feature | `quality` |
| Evidence path no longer exists / symbol gone | `outdated` |
| Doc statement contradicted by current code | `outdated` |
| Code contradicts documented intent | `suspected-bug` |
