---
name: research
description: Investigate a question against high-trust primary sources (codebase, git history, issue tracker, architecture docs, or official docs) and capture cited findings without polluting the Git repo.
---

# Research

Investigate a question thoroughly against **primary sources** (codebase symbols, `git log` / `git blame`, architecture docs, the project's issue tracker via `acli`/`gh`, or official upstream documentation).

1. **Prefer primary sources over secondary summaries**: Verify claims directly against code, tests, runtime configs, and git history.
2. **Subagent or direct**: For broad multi-file or multi-source investigations, dispatch a `research` subagent so your main context window stays clean.
3. **Zero Git Pollution**: Present concise findings inline in chat with clickable `file://` links, or if a standalone report is needed, write it to the Antigravity session artifact directory (`~/.gemini/antigravity/brain/<conversation-id>/research-<slug>.md`) or `$TMPDIR`. **Never** write untracked research markdown files into the Git repository.
