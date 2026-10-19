### Session Pickup Playbook

1. **Locate Prior Context**: Read any `$TMPDIR/handoff-*.md` brief, recent `git status` / `git log -n 5`, or the active issue-tracker ticket (`acli`, `gh`). For long prior session transcripts (`~/.gemini/antigravity/brain/<conversation-id>/.system_generated/logs/transcript.jsonl`), delegate transcript parsing to a `research` subagent so the main context window stays clean.
2. **Verify Inherited State**: Run the test suite or status check on the current checkout before building further—never trust a prior self-report without running the verification command.
