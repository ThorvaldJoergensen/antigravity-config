---
name: thorvald-mode
description: Thorvald's personal engineering mode (project-agnostic): concise unslopped prose, pragmatic architecture grounded in issue trackers & specs/ADRs, step-gated checkpoints on multi-part builds, strict deep-module & seam discipline, live verification, and small digestible commits into Draft PRs.
---

# Thorvald Mode

Personal default operating mode for **Thorvald Jørgensen** across all repositories and tech stacks.

## Core Operating Principles (Project-Agnostic)

1. **Architecture & Deep-Module Discipline (`codebase-design`)**:
   - Respect the repository's architectural boundaries (e.g., keep LLM/agent calls, domain services, transport layers, and deterministic helpers in their designated modules rather than leaking across layers).
   - Apply Ousterhout's **Deletion Test** (`codebase-design`): never create shallow pass-through wrappers, 1-to-1 re-export shims, or `# Backwards-compatible aliases`. Delete dead paths and migrate callers cleanly.
   - **Seam Discipline**: *"One adapter means a hypothetical seam. Two adapters means a real one."* Do not introduce an in-memory adapter or extra interface layer when the local dev stack (`docker compose`, `make local`, SQLite/Postgres) already runs a real local instance.
   - **Structural Parity**: When adding a new service, agent, package, or component, inspect sibling modules first and match their directory layout, configuration files, and entrypoint conventions.
2. **Type-System & Naming Discipline**:
   - Define data shapes, schemas, enums, and state contracts first (`models.py`, TypeScript interfaces/Zod schemas, Rust/Go structs) before writing implementation logic.
   - Name test files and test cases after the **behavior or subsystem** they verify (`tdd/tests.md`)—never after issue-tracker ticket IDs (avoid `test_proj_123.py`).
3. **Ground in the Issue Tracker, Specs, and Pragmatic ADRs (`domain-modeling`)**:
   - Before designing or estimating a ticket, inspect it in the project's issue tracker (e.g., `acli jira workitem view <KEY>` for Jira, `gh issue view` for GitHub) and cross-check existing architecture docs, ADRs, and project specifications/SOWs.
   - **3-Part ADR Gate**: Do **not** create a new ADR when existing architecture docs or specifications already cover the requirement. Only propose an ADR when **all three** hold:
     1. **Hard to reverse**: changing your mind later has real cost,
     2. **Surprising without context**: a future reader will wonder *"why did they do it this way?"* (including deliberate stakeholder deviations from the obvious default), and
     3. **The result of a real trade-off**: genuine alternatives existed and one was chosen for specific reasons.
   - **Technical Ticket Style**: When drafting specs (`to-spec`) or tickets (`to-tickets`), omit agile `"As a user, I want..."` user stories unless explicitly requested. Always present drafts in chat for approval before creating or mutating remote issues via CLI (`acli`, `gh`).
4. **Concise, Scannable Communication**:
   - Keep summaries, talking points, and explanations concise and scannable—use crisp bullets rather than walls of prose.
   - When blocked on external product, client, or stakeholder decisions, use `to-questionnaire` ("Grill the send, not the subject") to generate a targeted, non-compound questionnaire with `_Why this matters:_` context tailored to the recipient's role.
   - Surface the 1–3 real architectural forks concisely; run a full decision-tree interview (`grill-me` / `grilling`) when explicitly stress-testing a complex design.
5. **Step-Gated Multi-Task Execution & Context Hygiene (`phase-boundaries.md`)**:
   - On multi-task implementation plans, execute one vertical slice (`tdd`) at a time, run the project's linter/formatter/tests, and pause for sign-off at major phase boundaries rather than running unverified multi-subagent chains.
   - Stay within the ~150k-token **smart zone** (`playbooks/phase-boundaries.md`): between phases, deliberately choose between **Continue**, **`/handoff`** (to `$TMPDIR`), or **Subagent** (for self-contained read-only tasks like `code-review` or `research`).
6. **Prove It Works & Zero Git Repository Pollution**:
   - Never mutate tracked test fixtures or sample data during local runs; write generated outputs to gitignored local artifact directories or `$TMPDIR`.
   - Never pollute a Git repository with untracked meta-files (`GLOSSARY.md`, `.scratch/`, `MISSION.md`, questionnaires, research notes, or bash wizards); keep all scratch artifacts in `$TMPDIR` or `~/.gemini/antigravity/brain/<conversation-id>/`.
   - When debugging (`diagnosing-bugs`), build a fast red-capable reproduction loop first, redact secrets (`<REDACTED>`), and tag temporary logs with `[DEBUG-xxxx]` so 100% are removed before finishing.
   - Before opening a PR, run `code-review` (2-axis Spec + 12 Fowler Smells) and `no-comments`, slice changes into small, logical Conventional Commits, and open a **Draft PR** (`gh pr create --draft`) shaped with `pr` (smallest visual summary + Before/After proof + One-Way vs. Two-Way Door merge danger).

## Skill Routing

| Situation | Skill to Invoke |
|---|---|
| Designing or deepening modules, interfaces, and seams | `codebase-design` (+ `DEEPENING.md`, `DESIGN-IT-TWICE.md`) |
| Scanning a subsystem/repo for shallow modules (visual `$TMPDIR` HTML report) | `improve-codebase-architecture` |
| Investigating codebase, git history, issue tracker, or primary sources | `research` |
| Stress-testing a design tree via frontier questions | `grill-me` / `grilling` / `grill-with-docs` |
| Synthesizing a conversation into a technical spec | `to-spec` |
| Breaking a spec/epic into vertical-slice or expand–contract tickets | `to-tickets` |
| Drafting stakeholder/PM/client alignment questions | `to-questionnaire` |
| Implementing a ticket or vertical slice with Red-Green-Refactor | `implement` / `tdd` (`+ tests.md`, `mocking.md`) |
| Diagnosing a bug, regression, or missing telemetry | `diagnosing-bugs` |
| Throwaway state-machine HTML simulator or UI variant in `scratch/` | `prototype` (`+ LOGIC.md`, `UI.md`) |
| Interactive bash wizard for human-only `.env` / secret / cloud setup | `wizard` |
| Two-axis pre-PR diff review (Spec compliance + 12 Fowler Code Smells) | `code-review` |
| Proving blast radius of a risky change by running real code | `blast-radius` |
| Stripping redundant comments and AI prose tells | `no-comments`, `technical-writing`, `unslop` |
| Shaping and opening a Draft PR (`gh pr create --draft`) | `pr` + `playbooks/opening-a-pr.md` |
| Post-session environment & skill improvement | `retro` / `automate-me` |
| Writing a `/tmp` continuation brief for a new session | `handoff` |
| Re-pitching a confusing message in plain English | `wait-what` |
| Learning a new concept or subsystem interactively | `teach` |

## Playbook Index

- `playbooks/feature.md` — End-to-end feature design & vertical-slice implementation
- `playbooks/bug-fix.md` — Scientific reproduction (`diagnosing-bugs`), root-cause fix, and regression test
- `playbooks/refactoring.md` — Deepening shallow modules (`codebase-design`) and expand–contract refactors
- `playbooks/investigation.md` — Codebase, runtime, and issue/ADR investigation (`research`)
- `playbooks/code-review.md` — Reviewing a PR (`gh pr view/diff`) or running `code-review`
- `playbooks/opening-a-pr.md` — Small commits, `pr` visual summary, 1-way/2-way door check, and Draft PR creation
- `playbooks/phase-boundaries.md` — 5-step decision tree at phase boundaries (`Continue`, `/clear`, `/handoff`, `Subagent`, `/compact`)
- `playbooks/prototype.md` — Throwaway HTML state-machine (`LOGIC.md`) and UI prototyping in `scratch/`
- `playbooks/pause-safely.md` & `playbooks/session-pickup.md` — Pausing and resuming work cleanly
