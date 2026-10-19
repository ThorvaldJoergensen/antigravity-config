---
name: implement
description: Build the work described by a spec or ticket, driving /tdd at clean seams and closing out with /code-review before committing.
---

# Implement

Implement a ticket or spec with high discipline across any project:

1. **Read the source**: Fetch the ticket from the project's issue tracker (`acli jira workitem view <KEY>`, `gh issue view <NUM>`, or local spec in context) and check existing architecture docs + sibling modules for structural parity.
2. **Drive `/tdd`**: Build one vertical slice at a time following `~/.gemini/config/skills/tdd/SKILL.md` (`tests.md` and `mocking.md`).
3. **Verify continuously**: Run the project's linter, formatter, typechecker, and targeted test runner (e.g., `uv run ruff` + `uv run pytest`, `npm test`, `cargo test`, `go test`) after each slice, then the full affected test suite when done.
4. **Close out with `/code-review`**: Run the two-axis review (`Standards + 12 Fowler Smells` and `Spec compliance`) from `~/.gemini/config/skills/code-review/SKILL.md` over the diff.
5. **Commit discipline**: Present the verified result to the user before creating commits or pushing a Draft PR (`gh pr create --draft`).
