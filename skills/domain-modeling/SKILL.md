---
name: domain-modeling
description: Build and sharpen a project's domain model. Use when discussing codebase terminology, writing or editing a GLOSSARY.md, or recording or editing an ADR.
---

# Domain Modeling

Actively build and sharpen the project's domain model as you design. This is the *active* discipline: challenging terms, inventing edge-case scenarios, and writing the glossary and decisions down the moment they crystallise. (Merely *reading* `GLOSSARY.md` for vocabulary is not this skill: that's a one-line habit any skill can do. This skill is for when you're changing the model, not just consuming it.)

## File structure

Read the repository's existing documentation first (`GLOSSARY.md`, `GLOSSARY-MAP.md`, `docs/adr/`, `docs/architecture/`, or project specs).

- **Working glossary default:** Capture working glossary definitions in `<appDataDir>/brain/<conversation-id>/glossary.md` rather than creating untracked root files.
- **Repository files:** Never create untracked `GLOSSARY.md` or `docs/adr/` files in the Git repository automatically. Update `GLOSSARY.md` in place only if the repo already tracks it and the user wants it updated; write into `docs/adr/` only after confirming with the user.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `GLOSSARY.md` or `<appDataDir>/brain/<conversation-id>/glossary.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account': do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

### Update the working glossary inline

When a term is resolved, record it immediately using [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md) in `<appDataDir>/brain/<conversation-id>/glossary.md` (or the tracked repo `GLOSSARY.md` if the user wants it updated). Don't batch these up: capture them as they happen.

Keep the glossary devoid of implementation details. Do not treat it as a spec, a scratch pad, or a repository for implementation decisions.

### Offer ADRs sparingly

Only offer to create an ADR when all three are true:

1. **Hard to reverse**: the cost of changing your mind later is meaningful
2. **Surprising without context**: a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off**: there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR. When all three hold, ask the user before writing a file into the project's ADR directory, using [ADR-FORMAT.md](./ADR-FORMAT.md).
