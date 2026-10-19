#!/usr/bin/env bash
set -euo pipefail

# agy-sync.sh — Sync your global Antigravity configuration across PCs/Macs.
# Manages:
#   - ~/.gemini/config/ (skills/, plugins/, rules/, etc.)
#   - ~/.agents/pstack-models.md (synced via ~/.gemini/config/agents/pstack-models.md)

CONFIG_DIR="${HOME}/.gemini/config"
AGENTS_DIR="${HOME}/.agents"
DEFAULT_ARCHIVE="${HOME}/antigravity-config-bundle.tar.gz"

stage_agents_into_config() {
  if [[ -f "${AGENTS_DIR}/pstack-models.md" ]]; then
    mkdir -p "${CONFIG_DIR}/agents"
    cp "${AGENTS_DIR}/pstack-models.md" "${CONFIG_DIR}/agents/pstack-models.md"
  fi
}

restore_agents_from_config() {
  if [[ -f "${CONFIG_DIR}/agents/pstack-models.md" ]]; then
    mkdir -p "${AGENTS_DIR}"
    cp "${CONFIG_DIR}/agents/pstack-models.md" "${AGENTS_DIR}/pstack-models.md"
  fi
}

cmd="${1:-help}"

case "${cmd}" in
  export)
    out="${2:-${DEFAULT_ARCHIVE}}"
    stage_agents_into_config
    tar -czf "${out}" -C "${HOME}" ".gemini/config"
    echo "Exported Antigravity config to: ${out}"
    echo "Copy this file to another PC and run:"
    echo "  tar -xzf $(basename "${out}") -C ~ && ~/.gemini/config/agy-sync.sh apply"
    ;;

  import)
    in_file="${2:-${DEFAULT_ARCHIVE}}"
    if [[ ! -f "${in_file}" ]]; then
      echo "Archive not found: ${in_file}" >&2
      exit 1
    fi
    tar -xzf "${in_file}" -C "${HOME}"
    restore_agents_from_config
    echo "Imported Antigravity config into ${CONFIG_DIR} and ${AGENTS_DIR}."
    ;;

  apply)
    restore_agents_from_config
    echo "Applied Antigravity configuration on $(hostname)."
    echo "Installed skills ($(ls -1 "${CONFIG_DIR}/skills" | wc -l | tr -d ' ')):"
    ls -1 "${CONFIG_DIR}/skills" | sed 's/^/  - /'
    ;;

  init-git)
    remote_url="${2:-}"
    stage_agents_into_config
    cd "${CONFIG_DIR}"
    if [[ ! -d .git ]]; then
      git init -b main
    fi
    cat > .gitignore << 'EOF'
.DS_Store
*.pyc
__pycache__/
EOF
    git add -A
    git commit -m "chore: snapshot Antigravity global configuration" || true
    if [[ -n "${remote_url}" ]]; then
      git remote remove origin 2>/dev/null || true
      git remote add origin "${remote_url}"
      git push -u origin main
      echo "Pushed ~/.gemini/config to ${remote_url}"
    else
      echo "Initialized Git repo in ${CONFIG_DIR}. Add a remote with:"
      echo "  git -C ~/.gemini/config remote add origin <git-url> && ~/.gemini/config/agy-sync.sh push"
    fi
    ;;

  push)
    stage_agents_into_config
    cd "${CONFIG_DIR}"
    git add -A
    git commit -m "chore: sync Antigravity configuration ($(date +%Y-%m-%d))" || true
    git push
    echo "Pushed latest Antigravity config to remote."
    ;;

  pull)
    cd "${CONFIG_DIR}"
    git pull --rebase
    restore_agents_from_config
    echo "Pulled and applied latest Antigravity config."
    ;;

  *)
    cat << 'EOF'
Usage: ~/.gemini/config/agy-sync.sh <command> [args]

Commands:
  export [path]         Create a single-file archive (default: ~/antigravity-config-bundle.tar.gz)
  import [path]         Extract an archive into ~/.gemini/config and ~/.agents
  apply                 Restore ~/.agents files after cloning ~/.gemini/config on a new PC
  init-git [remote-url] Turn ~/.gemini/config into a Git repo (and optionally push to remote-url)
  push                  Commit and push any skill/plugin updates in ~/.gemini/config
  pull                  Pull latest changes on another PC and apply them
EOF
    ;;
esac
