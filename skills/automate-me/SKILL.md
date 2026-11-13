---
name: automate-me
description: "Use for \"automate me\", \"create/update/refresh my -mode skill\", \"turn/capture my preferences or working style into a skill\", or wanting agents to follow how the user works. Drafts or revises a personal -mode skill via writing-for-agents + unslop, optionally pulling fresh evidence from recent transcripts."
---

# Automate me

A guided flow for turning the user's working conventions into a project-agnostic Antigravity skill agents will follow. The output is one `-mode` skill tailored to them (e.g. `thorvald-mode`).

This skill orchestrates three parts: an inline transcript-mining pass (step 1), skill authoring (`writing-for-agents` + Antigravity's `agy-customizations` skill docs), and the **unslop** skill (prose discipline). It sequences them; it doesn't replace them.

## Flow

### 0. Check for an existing skill

Look for `*-mode/SKILL.md` matching the user's handle in Antigravity's skill folders:
- Global user skills: `~/.gemini/config/skills/` (`%USERPROFILE%\.gemini\config\skills\` on Windows)
- Project skills: `.agents/skills/`

If one exists, confirm intent with `ask_question` unless the user already asked to update it:

- Update the existing skill (default for repeat runs)
- Start fresh (rare; ask why before doing it)

Update mode changes the rest of the flow:
- Step 1 mines only history since the skill was last edited (`git log -1 --format=%cI <path>` if tracked).
- Step 2 asks what's changed or missing, not what to capture from zero.
- Step 4 edits the existing file in place. Preserve sections the user hasn't contradicted. Revise ones with new evidence. Add new sections only for genuinely new rules.

### 1. Mine their history

Antigravity stores session logs at `<appDataDir>/brain/<conversation-id>/.system_generated/logs/transcript.jsonl` (start with compact `transcript.jsonl`; read matching lines in `transcript_full.jsonl` only when `truncated_fields` is present). Scope mining to sessions belonging to the relevant workspace or workflow rather than blindly pulling unrelated private project details.

Survey recent conversations within scope for recurring patterns. Launch parallel subagents with `invoke_subagent` across slices of history (for example, 3 recent slices). Choose each subagent's `Model` (`flash_lite`, `flash`, `pro`, `inherit`) per the Subagents section of the **thorvald-mode** skill. Each slice-mining subagent reads its assigned transcripts, hunts for the signals below, and returns a short structured list of patterns with evidence pointers. Default signals:

- Response preferences (length, tone, format, "dumb it down" corrections)
- Delegation habits (subagents, models, specialized workflows, parallelism)
- Verification posture (what "done" means, unit tests vs live repro, reviewers)
- Code and prose discipline (style, principles cited, lint/format tools)
- Process conventions (worktrees, commits, PRs, review/merge tooling)
- Meta preferences (fixing skills mid-task, proposing new ones)

Cross-check across slices before elevating a signal. Patterns seen in 2+ slices are high-confidence. Lone signals are weak and usually get dropped.

### 2. Ask the user directly

Mining misses intent that hasn't come up yet. Use `ask_question` rather than asking the user to type from scratch.

Shape: one or two questions with 4–6 options each, using `is_multi_select: true` for category questions. Start broad ("Which areas matter most?"), then follow up on selected areas with specific options. After the structured rounds, one free-form chat question catches anything the options missed.

Don't dump 20 questions.

### 3. Cluster findings

Group the combined signals into sections. Common ones (use only what applies):

- **Response style**: length, tone, format.
- **Autonomy**: how much to do without asking, MCP tool use.
- **Understand first**: which skills to reach for when scoping or investigating a change.
- **Subagents**: default, parallelism, model-to-task (`flash_lite`, `flash`, `pro`, `inherit`), specialized workflows.
- **Prose / code discipline**: principles, lint tools, style guides.
- **Review and verify**: repro posture, verification skills, live-testing tools.
- **Process**: git worktrees, commits, PRs, review/merge tooling.
- **Skills**: skill-authoring habits, fix-the-skill-first, proposing new skills.

Read **thorvald-mode** for structural granularity, not content. The user's rules may differ.

### 4. Draft the skill

Follow **writing-for-agents** and Antigravity's `agy-customizations` (`docs/skills.md`) rules:

- Path: `~/.gemini/config/skills/<handle>-mode/SKILL.md` (`%USERPROFILE%\.gemini\config\skills\<handle>-mode\SKILL.md` on Windows) for a personal global mode skill, or `.agents/skills/<handle>-mode/SKILL.md` in a project.
- Handle: the user's first name or chosen identifier.
- Frontmatter `name` and `description`: lowercase hyphenated `name`; `description` as a single YAML scalar triggering on their name, `/<handle>-mode`, and "work in their style" (not generic keywords like "write code").
- Scope: keep all rules inside global `-mode` skills **project-agnostic** (general engineering habits, architecture boundaries, verification discipline, and communication style rather than hardcoding one repo's filenames or stakeholders).

### 5. Iterate on prose

Apply **unslop** and **writing-for-agents** to every line.

Show the draft to the user and take feedback. Expect multiple iterations. Cut ruthlessly. A mode skill is not a manual.

## Guardrails

- **Don't overfit to one conversation.** A preference stated once and contradicted another time is noise. Require multiple instances before codifying it.
- **Don't be clever.** Restating other skills' contents, inventing metaphors, or writing "poetic" prose for an agent reader is cost without benefit. Keep it operational.
- **Reference, don't inline.** Other skills the user relies on should appear as path references, not pasted excerpts. Same for any principle docs they maintain elsewhere.
- **Keep sections minimal.** Only add a section if the user has a specific, non-default rule there. "Communicate clearly" is not a section. "Short paragraphs. Tables when comparing options. Bullets only when items are genuinely parallel." is.
- **Name conventions generic.** Use "the user" or "the human" in imperatives, not the author's first name.
- **Don't force symmetry.** If a user has no process rules worth writing down, skip the Process section entirely.

## Evaluation

A `-mode` skill is subjective output. Vibe-check with the user: does it read like them? Did it miss anything? Revise until it lands.

## When not to use

- User wants a task-specific skill (not working conventions): use **writing-for-agents** directly, no mining required.
- User wants to capture one narrow workflow (e.g. "how I write commit messages"). That's a regular skill, not a mode skill.
