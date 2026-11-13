---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check whether a state model or logic feels right, or explore what a UI should look like.
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Identify which question is being answered, using the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build a single shareable HTML file (free-play buttons plus tabbed guided walkthroughs) that pushes the state machine through cases that are hard to reason about on paper, and that a non-developer can drive.
- **"What should this look like?"** → [UI.md](UI.md). Generate several radically different UI variations on a single route, switchable via a URL search param and a floating bottom bar.

The two branches produce very different artifacts, so getting this wrong wastes the whole prototype. If the question is genuinely ambiguous and the user isn't reachable, default to whichever branch better matches the surrounding code (a backend module → logic; a page or component → UI) and state the assumption at the top of the prototype.

## Rules that apply to both

1. **Throwaway and zero Git pollution.** Build standalone HTML/JS prototypes inside the OS temp directory (`$TMPDIR` or `/tmp` on macOS/Linux, `%TEMP%` on Windows) or `<appDataDir>/brain/<conversation-id>/scratch/`, and open them in the browser (`open <path>` on macOS, `xdg-open <path>` on Linux, `start "" "<path>"` on Windows). Never wire throwaway files into tracked Git repository routes or commit/push `prototype/<name>` branches unless the user explicitly asks.
2. **Trivial to run.** A logic demo is a single self-contained HTML file the user double-clicks. If a UI prototype must run inside an app shell, start it from one command (`pnpm <name>`, `python <path>`, etc.) without leaving tracked edits behind.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is _checking_, not something it should depend on. If the question explicitly involves a database, hit a scratch DB or a local temp file with a clear `PROTOTYPE` name.
4. **Skip the polish.** No tests, no error handling beyond what makes the prototype _runnable_, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action (logic) or on every variant switch (UI), print or render the full relevant state so the user can see what changed.
6. **Capture the answer when done.** Fold any validated decision (type, reducer, schema, or layout choice) into real code or the issue tracker/spec, and clean up throwaway working files in the repo unless the user asked to preserve a branch.
