### Refactoring Playbook

1. **Pin Behavior First**: Ensure existing integration/interface tests pass before moving code.
2. **Apply `codebase-design` (`DEEPENING.md`)**: Use the Deletion Test to eliminate shallow wrappers, 1-to-1 shims, and single-adapter seams. Subtract dead code before adding new structure.
3. **No Backwards-Compatibility Shims**: Migrate all in-repo callers and delete the old interface in the same change (or sequence wide refactors via `to-tickets` as *Expand -> Migrate -> Contract*). Never leave `# Backwards-compatible aliases` behind.
4. **Prove Equivalence**: Run the full affected test suite, linter, and a live smoke verification (`blast-radius`) to prove behavior is preserved.
