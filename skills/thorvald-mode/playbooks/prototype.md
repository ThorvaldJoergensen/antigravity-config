### Prototype Playbook

1. **Drive `prototype` (`LOGIC.md` & `UI.md`)**: Build a fast, throwaway prototype to test a state machine, domain rule, or UI interaction.
2. **Zero Git Pollution**: Keep all prototype files strictly inside `$TMPDIR` or `~/.gemini/antigravity/brain/<conversation-id>/scratch/` and open them in the browser (`open <path>`). Never wire throwaway code into tracked production routes or push `prototype/*` branches unless explicitly asked.
