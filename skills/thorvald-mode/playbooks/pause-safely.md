### Pause Safely Playbook

1. **Leave the Tree Runnable**: Before pausing mid-task, either finish the current vertical slice so tests pass or run `handoff` to write a continuation brief in the OS temp dir (`$TMPDIR` or `%TEMP%`).
2. **Summarize State Clearly**: List what is verified, what is in-flight, and the exact next command or file to pick up.
