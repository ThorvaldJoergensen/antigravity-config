#!/usr/bin/env bash
set -euo pipefail

# agy-sync.sh — Non-destructive cross-PC sync for ~/.gemini/config
CONFIG_DIR="${HOME}/.gemini/config"
AGENTS_DIR="${HOME}/.agents"
DEFAULT_ARCHIVE="${HOME}/antigravity-config-bundle.tar.gz"
REPO_URL="git@github.com:ThorvaldJoergensen/antigravity-config.git"

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

ensure_repo_initialized() {
  mkdir -p "${CONFIG_DIR}"
  cd "${CONFIG_DIR}"
  if [[ ! -d .git ]]; then
    git init -b main
    git remote add origin "${REPO_URL}" 2>/dev/null || git remote set-url origin "${REPO_URL}"
    git fetch origin
    git branch --set-upstream-to=origin/main main 2>/dev/null || true
  fi
}

cmd="${1:-help}"

case "${cmd}" in
  bootstrap|pull)
    mkdir -p "${CONFIG_DIR}"
    cd "${CONFIG_DIR}"
    if [[ ! -d .git ]]; then
      echo "Initializing Git in existing ${CONFIG_DIR} without deleting local files..."
      git init -b main
      git remote add origin "${REPO_URL}" 2>/dev/null || git remote set-url origin "${REPO_URL}"
      git fetch origin
      git checkout -B main origin/main
    else
      git pull --rebase origin main
    fi
    restore_agents_from_config
    echo "Synced and applied Antigravity config in ${CONFIG_DIR}."
    ;;

  push)
    ensure_repo_initialized
    stage_agents_into_config
    find "${CONFIG_DIR}" -mindepth 2 -name ".git" -type d -prune -exec rm -rf {} +
    cd "${CONFIG_DIR}"
    git add -A
    if ! git diff --cached --quiet; then
      git commit -m "chore: sync Antigravity configuration ($(date +%Y-%m-%d))"
    fi
    git push origin main
    echo "Pushed latest Antigravity config to remote."
    ;;

  apply)
    restore_agents_from_config
    echo "Applied Antigravity configuration on $(hostname)."
    echo "Installed skills ($(ls -1 "${CONFIG_DIR}/skills" | wc -l | tr -d ' ')):"
    ls -1 "${CONFIG_DIR}/skills" | sed 's/^/  - /'
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
  pull / bootstrap   Safely initialize (if needed) or pull latest config without deleting existing files
  push               Commit and push any skill/plugin updates in ~/.gemini/config
  apply              Restore ~/.agents files and list installed skills
  export [path]      Create a single-file archive (default: ~/antigravity-config-bundle.tar.gz)
  import [path]      Extract an archive into ~/.gemini/config and ~/.agents
EOF
    ;;
esac
