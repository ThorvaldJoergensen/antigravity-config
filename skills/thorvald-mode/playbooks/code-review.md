### Code Review Playbook

1. **Fetch Context**: Inspect the PR or branch diff (`gh pr view`, `gh pr diff`, `git diff <base>...HEAD`) and any linked issue/ticket (`acli`, `gh`) + architecture docs.
2. **Run Two-Axis `code-review`**: Evaluate both **Spec Compliance** (missing requirements, scope creep, behavioral mismatches) and **Standards & Design** (Ousterhout's Deletion Test, boundary leaks, and the 12 Fowler Code Smells).
3. **Actionable Output**: Group findings by severity (`Blocking`, `High`, `Nit`) with clickable `file://` links and concrete fix recommendations.
