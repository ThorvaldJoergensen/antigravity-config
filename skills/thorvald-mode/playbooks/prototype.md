### Prototype Playbook

1. **Drive `prototype` (`LOGIC.md` & `UI.md`)**: Build a fast, throwaway prototype to test a state machine, domain rule, or UI interaction.
2. **Zero Git Pollution**: Keep all prototype files strictly inside the OS temp dir (`$TMPDIR` on macOS/Linux, `%TEMP%` on Windows) or `<appDataDir>/brain/<conversation-id>/scratch/` and open them in the browser (`open` on macOS, `xdg-open` on Linux, `start "" "<path>"` on Windows). Never wire throwaway code into tracked production routes or push `prototype/*` branches unless explicitly asked.
