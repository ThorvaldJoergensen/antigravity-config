---
name: ask-matt
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
---

# Ask Matt

You don't remember every skill, so ask.

Before stating what a skill does or recommending a step be skipped, read that skill's SKILL.md: the summaries here are for orientation only.

A **flow** is a path through the skills. Most paths run along one **main flow**, and two **on-ramps** merge onto it. Everything else is standalone, or a vocabulary layer that runs underneath.

## The main flow: idea → ship

The route most work travels. You have an idea and want it built.

1. **`/grill-with-docs`** sharpens the idea by interview. Start here whenever you are **working in a repository**: it tracks domain terms via `/domain-modeling` (in `<appDataDir>/brain/<conversation-id>/glossary.md` by default, or in tracked repo docs when asked) and flags hard-to-reverse ADR candidates. (No repo context? Use `/grill-me` instead, covered under Standalone. Both run `/grilling` underneath.)
2. **Branch: can you settle every question in conversation?** If a question needs a runnable answer (state, business logic, a UI you have to see), detour through a prototype, bridged by **`/handoff`** in both directions:
   - **`/handoff`** out, then open a fresh session against that file,
   - **`/prototype`** to answer the question with throwaway code in the OS temp dir or session `scratch/`,
   - **`/handoff`** back what you learned, and reference it from the original idea thread.
3. **Branch: is this a multi-session build?**
   - **Yes** → **`/to-spec`** (turn the thread into a spec), then **`/to-tickets`** to split it into tracer-bullet tickets, each declaring its **blocking edges**. Then work the tickets via **`/implement`** one at a time, resetting/starting fresh context between tickets. Local ticket drafts go to `<appDataDir>/brain/<conversation-id>/` (never untracked `.scratch/` in Git); on a real tracker (`acli`, `gh`, `glab`), blocking edges become native links.
   - **No** → **`/implement`** right here, in the same context window.

   Either way, **`/implement`** builds one vertical slice at a time by driving **`/tdd`** (one red-green slice at a time) and closes out with **`/code-review`**, a two-axis review (Standards + Spec) of the diff. Reach for **`/tdd`** on its own to build a concrete behaviour test-first without a full spec, and **`/code-review`** on its own to review a branch or PR against a fixed point.

   When the work goes up as a pull request, **`/pr`** shapes the body: the smallest visual that shows the change, before/after evidence that it works, and a one-way or two-way door call.

4. **`/retro`** closes the loop. After a build, and especially one that went sideways, it inspects the session and suggests improvements to your global Antigravity skills (or repo standards if requested): navigation pointers, automated checks, coding standards, or workflows. Mechanical mistakes become deterministic checks; judgement calls become coding standards.

### Context hygiene

Keep steps 1–3 in **one unbroken context window** (don't compact or clear until after `/to-tickets`) so the grilling, spec, and tickets all build on the same thinking. Each `/implement` then starts fresh, working from the ticket. Run `/retro` in the session it's looking back on, before you clear; after clearing, point it at that session's log instead.

The limit on this is the **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)**: the window (~150k tokens on state-of-the-art models) within which the model still reasons sharply. If a session approaches it before `/to-tickets`, don't push on degraded; `/compact` at the nearest phase boundary and carry on (see Phase boundaries).

## On-ramps

A starting situation that generates work, then merges onto the main flow.

- **Something's broken** → **`/diagnosing-bugs`**. For the hard ones: the bug that resists a first glance, the intermittent flake, the regression that crept in between two known-good states. It refuses to theorise until it has a **tight feedback loop** (one command that already goes red on *this* bug), then fixes with a regression test. Once the fix is in, run **`/retro`** in the same session to ask what would have prevented the bug; where the real finding is that there's no good seam to lock it down, that's a job for **`/improve-codebase-architecture`**.
- **Risky change before shipping** → **`/blast-radius`**. Traces downstream breakage beyond grep and proves safety by running real code.
- **A huge, foggy effort: a greenfield project or large feature** → Start with **`/research`** against primary sources, run **`/grill-with-docs`** to resolve the open forks, then synthesize with **`/to-spec`** and **`/to-tickets`**.

## Codebase health

Not feature work, just upkeep.

- **`/improve-codebase-architecture`** runs whenever you want to keep the codebase good for agents to operate in. It surfaces **deepening opportunities**; picking one _generates an idea_ you can take into the main flow at `/grill-with-docs`. It's the survey that finds the candidates; **`/codebase-design`** (below) is the bench you design the chosen one on.
- **`/no-comments`** removes redundant comment narration and lint/type suppression bloat inside your diff, then turns claimed constraints into enforceable checks.
- **`/create-verification-skill`** generates a project-local `verify-<app>` skill so agents can drive and prove real app behaviour.

## Vocabulary underneath

Two model-invoked references that run *beneath* the other skills, each the single source of truth for its vocabulary. Reach for them directly when the **words**, not the process, are the problem; or let the skills above pull them in.

- **`/domain-modeling`**: sharpen the project's *domain* language: challenge a fuzzy term, resolve an overloaded word ("account" doing three jobs), record a hard-to-reverse decision as an ADR. It's the active discipline `/grill-with-docs` drives to keep terminology clean.
- **`/codebase-design`** is the deep-module vocabulary (module, interface, depth, seam, adapter, leverage, locality) for designing a module's *shape*: a lot of behaviour behind a small interface at a clean seam. `/tdd` and `/improve-codebase-architecture` both speak it.

## Phase boundaries

A **phase** is a chunk of work inside a session: the grilling, the implementation, the QA. At the **boundary** between two of them you have five options:

- **Continue**: stay put. Costs nothing, loses nothing.
- **`/clear`** (new session): start fresh when nothing here matters to what's next.
- **`/handoff`** writes a portable markdown file. Narrow: only for a **new harness**, a **new directory**, a **colleague**, or forking a side task **mid-phase**. What it buys is portability.
- **Subagent**: send a tightly-scoped task to its own window (`invoke_subagent`) and get a report back.
- **`/compact`**: compress context and carry on when approaching the ~150k-token smart zone.

Read [phase-boundaries.md](../thorvald-mode/playbooks/phase-boundaries.md) for the ordered decision tree: the five questions and the reasoning behind each branch. Make the decision **at** a boundary; mid-phase, continue or split the rest into subagents.

## Standalone

Off the main flow entirely.

- **`/thorvald-mode`**: Thorvald's default project-agnostic engineering mode (deep modules, 3-part ADR gate, subagent tier routing, zero Git pollution, Draft PRs).
- **`/grill-me`**: the same relentless interview as `/grill-with-docs`, but **stateless**: it saves nothing locally and tracks no glossary. Reach for it when you are **not working in a repo**. If you are in a repo, use `/grill-with-docs` instead.
- **`/grilling`** is the interview primitive itself: rounds, the frontier, facts are the agent's job and decisions are yours. `/grill-me`, `/grill-with-docs`, and `/improve-codebase-architecture` all run it internally.
- **`/prototype`** builds a small, throwaway HTML demo or UI variant in the OS temp dir or session `scratch/` to settle a state-model or layout question without polluting Git.
- **`/research`**: delegate reading legwork to a `research` subagent against **primary sources**, delivering findings in chat or `<appDataDir>/brain/<conversation-id>/`.
- **`/to-questionnaire`** turns a gap someone else holds into a targeted questionnaire (saved in `<appDataDir>/brain/<conversation-id>/` or OS temp dir).
- **`/wizard`** generates an interactive bash wizard in OS temp dir or `scratch/` for steps only a human can perform (`.env`, CI secrets, cloud dashboards; Git Bash / WSL on Windows).
- **`/wait-what`** re-pitches a confusing message in plain English with missing context.
- **`/teach`**: learn a concept over multiple sessions inside a scratch or dedicated non-Git learning workspace.
- **`/writing-for-agents`** and **`/unslop`** + **`/technical-writing`**: tighten agent docs, skills, RFCs, READMEs, PRs, and commit messages.
- **`/automate-me`**: mine session transcripts and interview preferences to create or update a `-mode` skill.

## Issue Tracker & Zero-Git-Pollution Convention

All skills detect your project's issue tracker automatically (`acli` for Jira, `gh` for GitHub, `glab` for GitLab, or Linear) and keep temporary working files in the OS temp directory (`$TMPDIR` or `%TEMP%`) or `<appDataDir>/brain/<conversation-id>/` so your Git working tree stays clean.
