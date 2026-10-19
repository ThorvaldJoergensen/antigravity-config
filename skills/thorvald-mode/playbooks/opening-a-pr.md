### Opening a PR Playbook

1. **Commit Slicing**: Organize changes into small, logical, ordered Conventional Commits (`type(scope): subject`, such as `feat`, `fix`, `refactor`, `test`, `docs`, `chore`). Each commit should tell a clean story.
2. **Pre-PR Cleanup**: Run the project's formatter, linter, and test suite, then run `no-comments` and `code-review` over the branch diff.
3. **Shape the PR Body with `pr`, `technical-writing`, and `unslop`**:
   - Include the **smallest visual** that makes the change obvious (ASCII call-tree diff, state diagram, or Mermaid flow).
   - Provide **Before/After** verification evidence.
   - Include **Merge Danger**: Blast Radius + **One-Way Door vs. Two-Way Door** classification (e.g., DB schema migrations vs. reversible code paths).
4. **Draft by Default**: Always create PRs as **Drafts** (`gh pr create --draft`) unless explicitly instructed to open ready for review.
