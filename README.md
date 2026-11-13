# Antigravity Global Configuration (`~/.gemini/config`)

Portable, project-agnostic, cross-OS (macOS, Windows, Linux/WSL) Google Antigravity configuration for **Thorvald Jørgensen** (`@ThorvaldJoergensen`).

## What Is Tracked in Git

Only portable global customizations are version-controlled (enforced by a whitelist `.gitignore`):

- **`skills/` (30 global skills)**:
  - **`thorvald-mode`**: Personal default engineering mode, explicit subagent model-tier routing (`flash_lite`, `flash`, `pro`), and 10 playbooks (`feature`, `bug-fix`, `refactoring`, `investigation`, `code-review`, `opening-a-pr`, `phase-boundaries`, `prototype`, `pause-safely`, `session-pickup`).
  - **Architecture, implementation & review skills**: `ask-matt`, `blast-radius`, `code-review`, `codebase-design`, `create-verification-skill`, `diagnosing-bugs`, `domain-modeling`, `grill-me`, `grill-with-docs`, `grilling`, `handoff`, `implement`, `improve-codebase-architecture`, `no-comments`, `pr`, `prototype`, `research`, `retro`, `tdd`, `teach`, `technical-writing`, `to-questionnaire`, `to-spec`, `to-tickets`, `unslop`, `wait-what`, `wizard`, `writing-for-agents`, `automate-me`.
- **`plugins/` (3 global plugins)**:
  - `gemini-api` (`gemini-api-cli`, `gemini-api-dev`, `gemini-live-api-dev`, `gemini-omni-flash-api` + Gemini API Docs MCP)
  - `google-antigravity-sdk`
  - `modern-web-guidance-plugin` (`modern-web-guidance`, `chrome-extensions`)
- **`.gitignore` & `.gitattributes`**: Whitelist ignore rules and LF/CRLF line-ending enforcement across Windows, macOS, and Linux.

## What Stays Local on Each PC (Never Overwritten)

- **Inside `~/.gemini/config/` (gitignored)**:
  - `projects/*.json` (machine-local project workspaces, folder URIs, and sandbox permission grants)
  - `config.json` (machine-local user settings, hostnames, and per-plugin enable/disable toggles)
  - `mcp_config.json`, `import_manifest.json`, `.migrated`, `sidecars/`, `node_modules/`
- **Outside `~/.gemini/config/`**:
  - `~/.gemini/antigravity/` (conversations, `brain/` artifacts, transcripts)
  - `~/.gemini/projects.json`, `oauth_creds.json`, `google_accounts.json`
  - `~/.gemini/antigravity-cli/settings.json` (CLI trust & statusline config)

---

## 1. First-Time Setup on a New PC (Preserves Local Projects & Chats)

Do **not** delete `~/.gemini/config` if Antigravity has already run on the machine (deleting it removes local `projects/*.json` and `config.json`). Initialize in place instead:

### macOS / Linux (`bash` / `zsh`)

```bash
mkdir -p ~/.gemini/config
git -C ~/.gemini/config init -b main
git -C ~/.gemini/config remote add origin git@github.com:ThorvaldJoergensen/antigravity-config.git
git -C ~/.gemini/config fetch origin
git -C ~/.gemini/config reset origin/main
git -C ~/.gemini/config branch --set-upstream-to=origin/main main
git -C ~/.gemini/config checkout -f HEAD -- .gitignore .gitattributes README.md skills plugins
git -C ~/.gemini/config clean -fd -- skills plugins
```

### Windows (`PowerShell`)

```powershell
$cfg = "$env:USERPROFILE\.gemini\config"
New-Item -ItemType Directory -Force -Path $cfg | Out-Null
git -C $cfg init -b main
git -C $cfg remote add origin https://github.com/ThorvaldJoergensen/antigravity-config.git
git -C $cfg fetch origin
git -C $cfg reset origin/main
git -C $cfg branch --set-upstream-to=origin/main main
git -C $cfg checkout -f HEAD -- .gitignore .gitattributes README.md skills plugins
git -C $cfg clean -fd -- skills plugins
```

---

## 2. Pull & Replace `skills/` and `plugins/` on Any PC

Updates `skills/` and `plugins/` to match `origin/main` (removing deleted or untracked skills/plugins) without touching `config.json`, `projects/*.json`, or conversations:

### macOS / Linux (`bash` / `zsh`)

```bash
git -C ~/.gemini/config fetch --prune origin
git -C ~/.gemini/config reset origin/main
git -C ~/.gemini/config checkout -f HEAD -- .gitignore .gitattributes README.md skills plugins
git -C ~/.gemini/config clean -fd -- skills plugins
```

### Windows (`PowerShell`)

```powershell
$cfg = "$env:USERPROFILE\.gemini\config"
git -C $cfg fetch --prune origin
git -C $cfg reset origin/main
git -C $cfg checkout -f HEAD -- .gitignore .gitattributes README.md skills plugins
git -C $cfg clean -fd -- skills plugins
```

---

## 3. Push Skill or Plugin Updates

Stage only portable customizations so machine-local `projects/` and `config.json` are never pushed:

### macOS / Linux (`bash` / `zsh`)

```bash
git -C ~/.gemini/config add -A -- skills plugins README.md .gitignore .gitattributes
git -C ~/.gemini/config commit -m "Update Antigravity skills/plugins"
git -C ~/.gemini/config push
```

### Windows (`PowerShell`)

```powershell
$cfg = "$env:USERPROFILE\.gemini\config"
git -C $cfg add -A -- skills plugins README.md .gitignore .gitattributes
git -C $cfg commit -m "Update Antigravity skills/plugins"
git -C $cfg push
```
