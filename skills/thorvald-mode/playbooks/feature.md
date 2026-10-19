### Feature Implementation Playbook

1. **Ground in Primary Sources**: Fetch the ticket from the issue tracker (`acli`, `gh`, etc.) and check existing architecture docs, ADRs, and sibling modules for structural parity.
2. **Resolve Ambiguities Early**: Surface the 1–3 real architectural forks concisely (or run `grill-me` for complex design trees). If blocked on external stakeholder input, run `to-questionnaire`.
3. **Model Types & Boundaries First (`codebase-design`)**: Define domain types, enums, and public module interfaces before writing logic. Apply Ousterhout's Deletion Test so no shallow pass-through wrappers are introduced.
4. **Build in Step-Gated Vertical Slices (`tdd`)**: Implement one vertical tracer-bullet slice at a time (Red -> Green -> Refactor), verifying with the project's linter, formatter, typechecker, and test suite after each slice.
5. **Pre-PR Quality Gate**: Run `code-review` (Standards + 12 Fowler Smells & Spec compliance) and `no-comments`, then follow `playbooks/opening-a-pr.md`.
