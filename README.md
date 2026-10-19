# Antigravity Global Configuration (`~/.gemini/config`)

Personal, project-agnostic Google Antigravity agent configuration for **Thorvald Jørgensen** (`@ThorvaldJoergensen`).

## What's Inside

- **`skills/` (30 global skills)**:
  - **`thorvald-mode`**: Personal default operating mode & 10 project-agnostic playbooks (`feature`, `bug-fix`, `refactoring`, `investigation`, `code-review`, `opening-a-pr`, `phase-boundaries`, `prototype`, `pause-safely`, `session-pickup`).
  - **23 Matt Pocock skills** (adapted for Antigravity, multi-tracker support via `acli`/`gh`, and zero Git repository pollution):
    - *Engineering (16)*: `codebase-design`, `diagnosing-bugs`, `improve-codebase-architecture`, `to-tickets`, `to-spec`, `code-review`, `pr`, `domain-modeling`, `wizard`, `tdd`, `retro`, `ask-matt`, `prototype`, `grill-with-docs`, `implement`, `research`
    - *Productivity (7)*: `to-questionnaire`, `grilling`, `grill-me`, `writing-for-agents`, `handoff`, `wait-what`, `teach`
  - **6 Non-Overlapping `pstack` utilities**: `automate-me`, `blast-radius`, `create-verification-skill`, `no-comments`, `technical-writing`, `unslop`
- **`plugins/`**: Global Antigravity plugins (`gemini-api`, `google-antigravity-sdk`, `modern-web-guidance-plugin`).
- **`agents/pstack-models.md`**: Synced copy of `~/.agents/pstack-models.md` (`inherit-parent` model policy).
- **`agy-sync.sh`**: Cross-machine synchronization utility.

---

## Quick Start on a New PC / Mac

### 1. Clone into `~/.gemini/config` and apply

If `~/.gemini/config` does not exist yet:

```bash
git clone git@github.com:ThorvaldJoergensen/antigravity-config.git ~/.gemini/config
~/.gemini/config/agy-sync.sh apply
```

If Antigravity already created a default `~/.gemini/config` directory on the new machine:

```bash
rm -rf ~/.gemini/config
git clone git@github.com:ThorvaldJoergensen/antigravity-config.git ~/.gemini/config
~/.gemini/config/agy-sync.sh apply
```

*(Or with HTTPS / GitHub CLI: `gh repo clone ThorvaldJoergensen/antigravity-config ~/.gemini/config && ~/.gemini/config/agy-sync.sh apply`)*

---

## Everyday `agy-sync.sh` Commands

Run `~/.gemini/config/agy-sync.sh <command>` from anywhere:

| Command | Description |
|---|---|
| `~/.gemini/config/agy-sync.sh push` | Copies `~/.agents/pstack-models.md` into the repo, commits all skill/plugin updates in `~/.gemini/config`, and pushes to `origin/main`. |
| `~/.gemini/config/agy-sync.sh pull` | Pulls the latest changes from GitHub (`git pull --rebase`) and restores `~/.agents/pstack-models.md`. |
| `~/.gemini/config/agy-sync.sh apply` | Restores `~/.agents/pstack-models.md` and lists all active skills in `~/.gemini/config/skills`. |
| `~/.gemini/config/agy-sync.sh export [file]` | Packs `~/.gemini/config` into a single portable archive (default: `~/antigravity-config-bundle.tar.gz`) for offline transfer. |
| `~/.gemini/config/agy-sync.sh import [file]` | Extracts a portable `.tar.gz` bundle into `~/.gemini/config` and `~/.agents/`. |
