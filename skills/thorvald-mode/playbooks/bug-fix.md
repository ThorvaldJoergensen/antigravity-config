### Bug Fix Playbook

1. **Drive `diagnosing-bugs`**: Never guess a fix from reading code alone. First construct a fast, deterministic reproduction loop that goes red on the bug (trace replay, targeted test, CLI harness, or HITL script).
2. **Hygiene**: Redact all credentials/tokens (`<REDACTED>`) in notes and tag every temporary diagnostic log with `[DEBUG-xxxx]`.
3. **Root-Cause Fix at the Right Seam**: Form 3–5 ranked falsifiable hypotheses, narrow the input, fix the root cause (never bolt on symptom guards), and lock it in with a regression test named after the behavior (`tdd/tests.md`).
4. **Clean Up**: Grep for `DEBUG-` and remove 100% of diagnostic instrumentation before running `code-review` and `playbooks/opening-a-pr.md`.
