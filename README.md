# Antigravity Global Configuration (`~/.gemini/config`)

Personal, project-agnostic, cross-platform (macOS, Windows, Linux/WSL) Google Antigravity agent configuration for **Thorvald Jørgensen** (`@ThorvaldJoergensen`).

## What's Inside

- **`skills/` (30 global skills)**:
  - **`thorvald-mode`**: Personal default operating mode & 10 project-agnostic playbooks (`feature`, `bug-fix`, `refactoring`, `investigation`, `code-review`, `opening-a-pr`, `phase-boundaries`, `prototype`, `pause-safely`, `session-pickup`).
  - **23 Matt Pocock skills** (adapted for Antigravity, multi-tracker support via `acli`/`gh`, and zero Git repository pollution):
    - *Engineering (16)*: `codebase-design`, `diagnosing-bugs`, `improve-codebase-architecture`, `to-tickets`, `to-spec`, `code-review`, `pr`, `domain-modeling`, `wizard`, `tdd`, `retro`, `ask-matt`, `prototype`, `grill-with-docs`, `implement`, `research`
    - *Productivity (7)*: `to-questionnaire`, `grilling`, `grill-me`, `writing-for-agents`, `handoff`, `wait-what`, `teach`
  - **6 Non-Overlapping `pstack` utilities**: `automate-me`, `blast-radius`, `create-verification-skill`, `no-comments`, `technical-writing`, `unslop`
- **`plugins/`**: Global Antigravity plugins (`gemini-api`, `google-antigravity-sdk`, `modern-web-guidance-plugin`).
- **`agents/pstack-models.md`**: Synced copy of `~/.agents/pstack-models.md` (`inherit-parent` model policy).
- **`agy-sync.sh` & `agy-sync.ps1`**: Non-destructive cross-machine synchronization utilities for macOS/Linux/WSL/Git Bash (`.sh`) and native Windows PowerShell (`.ps1`).
- **`.gitattributes`**: Enforces LF line endings on `.sh` / `.py` / `.md` files so Windows `git clone` (`core.autocrlf`) never breaks bash scripts in WSL or Git Bash.

---

## Non-Destructive Setup on Any PC / Mac

Never delete `~/.gemini` or an existing `~/.gemini/config` directory. Both commands below detect whether `~/.gemini/config` already exists (or is already a Git repo) and safely initialize or pull **in-place** without deleting any existing files or projects:

### Windows (PowerShell)

Antigravity resolves `~/.gemini/config` to `$HOME\.gemini\config` (`C:\Users\<you>\.gemini\config`):

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.gemini\config" | Out-Null
if (-not (Test-Path "$HOME\.gemini\config\.git")) {
    git -C "$HOME\.gemini\config" init -b main
    git -C "$HOME\.gemini\config" remote add origin https://github.com/ThorvaldJoergensen/antigravity-config.git
    git -C "$HOME\.gemini\config" fetch origin
    git -C "$HOME\.gemini\config" checkout -B main origin/main
} else {
    git -C "$HOME\.gemini\config" pull --rebase origin main
}
& "$HOME\.gemini\config\agy-sync.ps1" apply
```

### macOS / Linux / WSL / Git Bash

```bash
mkdir -p ~/.gemini/config
if [ ! -d ~/.gemini/config/.git ]; then
  git -C ~/.gemini/config init -b main
  git -C ~/.gemini/config remote add origin git@github.com:ThorvaldJoergensen/antigravity-config.git
  git -C ~/.gemini/config fetch origin
  git -C ~/.gemini/config checkout -B main origin/main
else
  git -C ~/.gemini/config pull --rebase origin main
fi
~/.gemini/config/agy-sync.sh apply
```

---

## Everyday Sync Commands

| Action | macOS / Linux / WSL / Git Bash | Windows PowerShell |
|---|---|---|
| **Pull latest (or bootstrap in-place)** | `~/.gemini/config/agy-sync.sh pull` | `& "$HOME\.gemini\config\agy-sync.ps1" pull` |
| **Push local changes** | `~/.gemini/config/agy-sync.sh push` | `& "$HOME\.gemini\config\agy-sync.ps1" push` |
| **Apply / verify** | `~/.gemini/config/agy-sync.sh apply` | `& "$HOME\.gemini\config\agy-sync.ps1" apply` |
| **Export `.tar.gz`** | `~/.gemini/config/agy-sync.sh export` | `& "$HOME\.gemini\config\agy-sync.ps1" export` |
| **Import `.tar.gz`** | `~/.gemini/config/agy-sync.sh import` | `& "$HOME\.gemini\config\agy-sync.ps1" import` |
