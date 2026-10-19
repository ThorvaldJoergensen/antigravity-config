#!/usr/bin/env bash
set -euo pipefail

# agy-sync.sh — Sync your global Antigravity configuration across PCs/Macs.
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
  apply)
    restore_agents_from_config
    echo "Applied Antigravity configuration on $(hostname)."
    echo "Installed skills ($(ls -1 "${CONFIG_DIR}/skills" | wc -l | tr -d ' ')):"
    ls -1 "${CONFIG_DIR}/skills" | sed 's/^/  - /'
    ;;

  push)
    stage_agents_into_config
    find "${CONFIG_DIR}" -mindepth 2 -name ".git" -type d -prune -exec rm -rf {} +
    cd "${CONFIG_DIR}"
    git add -A
    if ! git diff --cached --quiet; then
      git commit -m "chore: sync Antigravity configuration ($(date +%Y-%m-%d))"
    fi
    git push
    echo "Pushed latest Antigravity config to remote."
    ;;

  pull)
    cd "${CONFIG_DIR}"
    git pull --rebase
    restore_agents_from_config
    echo "Pulled and applied latest Antigravity config."
    ;;

  export)
    out="${2:-${DEFAULT_ARCHIVE}}"
    stage_agents_into_config
    tar -czf "${out}" -C "${HOME}" ".gemini/config"
    echo "Exported Antigravity config to: ${out}"
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

  *)
    cat << 'EOF'
Usage: ~/.gemini/config/agy-sync.sh <command> [args]

Commands:
  apply           Restore ~/.agents files after cloning ~/.gemini/config on a new PC
  push            Commit and push any skill/plugin updates in ~/.gemini/config
  pull            Pull latest changes on another PC and apply them
  export [path]   Create a single-file archive (default: ~/antigravity-config-bundle.tar.gz)
  import [path]   Extract an archive into ~/.gemini/config and ~/.agents
EOF
    ;;
esac
