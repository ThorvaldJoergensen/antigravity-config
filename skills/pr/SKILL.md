---
name: pr
description: "Use when writing a PR body."
---

Write a short-to-medium length PR description that explains **what changed, why, and any bugs fixed** so a reviewer understands the change on the first read.

## Template

```markdown
## Background & Motivation

<1-2 short paragraphs explaining why this change is needed: the problem, historical context, or architectural decision driving the work.>

## What Changed

### 1. <Logical area of change>
- **<Component or concern>**: <What changed and why, naming real files, symbols, or config keys.>

### 2. Bug Fix: <Short bug title> (include when the PR fixes a bug)
- **Cause**: <The exact mechanism that caused the bug.>
- **Fix**: <What changed to resolve it.>

## Out of Scope / Kept Intentionally (optional — include when a reviewer might wonder why adjacent code was left untouched)
- <1-2 bullets explaining what was deliberately kept and why.>

## Verification
- <2-3 concise bullets stating what unit/integration tests and live service checks were run (no raw log dumps).>

## Local Setup / Config Notes (optional — include when `.env`, ports, migrations, or local commands change)
- <1-2 lines telling teammates what to update in their local `.env` or setup after pulling `main`.>
```

## Rules

- **Lead with the "why" and "what"**: A reviewer should immediately see the reason for the PR, the logical changes made, and the root cause of any bug fixed.
- **Name real symbols and paths**: Use exact file paths, function/class names, env vars, and ADR numbers from the codebase (`GLOSSARY.md` / repo terms).
- **Group by logical change, not file-by-file**: Combine related edits under clear numbered subsections (`### 1. ...`, `### 2. ...`).
- **Explain bugs via Cause + Fix**: State the exact mechanism that went wrong (**Cause**) followed by the concrete change (**Fix**).
- **Pre-answer reviewer questions**: Include `## Out of Scope / Kept Intentionally` when adjacent code looks removable at first glance, and `## Local Setup / Config Notes` whenever `.env`, ports, or migrations change.
- **Keep verification brief**: Summarize test and live-stack verification in 2–3 bullets without pasting raw terminal logs.
- **Draft PR by default**: When creating a PR with `gh pr create`, always pass `--draft` by default unless the user explicitly asks for a non-draft PR.
