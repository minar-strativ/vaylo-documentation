---
apkf_version: 2.0.0
name: Canopy — AI Product Knowledge Framework
---

# Canopy — Framework Entry Point

You are executing the AI Product Knowledge Framework. This file is the ONLY valid entry point. Read it fully before doing anything else.

## What this framework is

A process for generating and maintaining a **business-focused Product Knowledge Base** in `docs/product/`. You (the AI) are the runtime; these files are your operating manual. You never write product documentation outside this framework.

## Non-negotiable rules

1. **One feature at a time.** Never analyze or document two features in parallel.
2. **Save immediately.** After every atomic step, update `metadata/progress.json` and any changed metadata before proceeding.
3. **Resume from metadata, never from chat history.** Chat context is disposable; `metadata/` is the memory.
4. **Never regenerate completed work.** A feature with `status: completed` is only touched by Maintenance or Audit mode.
5. **Evidence or silence.** Every claim in a doc must trace to code you read this session, recorded in the inventory `evidence` map. If you can't find supporting code, write nothing and set `needs_review`.
6. **Business-first writing.** Docs explain product behavior for the audience declared in `rules/writing.md` — never code.
7. **No duplication.** Each business capability owns exactly one doc. Cross-reference; never copy.

## Session start procedure (every session, no exceptions)

1. Read this file.
2. Read `metadata/progress.json` and `metadata/inventory.json` (if they exist).
3. Determine the mode (below).
4. Read the corresponding `modes/<mode>.md` and the rules files it lists.
5. Continue from `current_feature` / `current_step` in progress.json. Do not restart finished steps.

## Mode selection

| Condition | Mode |
|---|---|
| User explicitly requests a mode | That mode |
| No `metadata/inventory.json` exists | **Create** (`modes/create.md`) |
| Inventory exists and progress.json shows an unfinished Create run | **Create** (resume) |
| Inventory exists, all features completed/skipped, code changed since anchors | **Maintain** (`modes/maintain.md`) |
| User asks to verify/validate/check docs | **Audit** (`modes/audit.md`) |

If ambiguous, state your mode choice and reasoning to the user in one sentence, then proceed.

## File map

| Path | Owner | Purpose |
|---|---|---|
| `framework.md` | framework | This file |
| `modes/create.md` `maintain.md` `audit.md` | framework | Mode procedures |
| `rules/analysis.md` | framework | How to discover and analyze features |
| `rules/granularity.md` | framework | What counts as a feature |
| `rules/writing.md` | framework | Audience, style, denylist |
| `rules/quality.md` | framework | Self-review checklist, validator rules |
| `templates/feature.md` | framework | Doc structure |
| `scripts/diff-since.sh` `check-evidence.sh` `lint-docs.sh` `validate-analysis.sh` | framework | Deterministic, zero-token checks the AI runs via Bash instead of reasoning over raw output |
| `glossary.md` | project | Canonical business terms |
| `metadata/inventory.json` | project | Features, file map, anchors, evidence, `analysis` facts |
| `metadata/progress.json` | project | Current run state (keep < 30 lines) |
| `metadata/changelog.md` | project | Append-only doc history |
| `docs/product/` | project | THE OUTPUT |

Framework upgrades replace framework-owned files wholesale and never touch project-owned files.

## Model tiering

Each mode's steps fall into two tiers. Claude Code doesn't auto-switch models mid-session, so this is stated as guidance per phase boundary — honor it by switching model (`/model` or `--model`) yourself, or via a wrapper, when a mode file's step notes call for it:

| Tier | When | Examples |
|---|---|---|
| **Mechanical** — fast/cheap model | Running the scripts in `scripts/`, repo-manifest pre-passes, structured fact extraction (the Analyzer step), inventory/changelog bookkeeping | Create Phase A0/B2, Maintain Phase A1–A2/B2, Audit Phase A0/A1 |
| **Judgment** — your default/strong model | Feature/granularity detection, turning facts into client-facing prose (the Writer step), comparing doc intent against code, suspected-bug calls | Create Phase A2–A4/B4, Maintain Phase A3/B4, Audit Phase A2, Phase B's semantic checks |

Every mode file calls out which tier its own steps recommend inline — this table is the summary, not the only place it's stated.

## Conflict rule

Code is the source of truth for **current behavior**; docs may record **intent**. On mismatch: Maintain mode updates the doc; Audit mode records a finding (`doc-outdated` or `suspected-bug`). Never silently rewrite documented intent.
