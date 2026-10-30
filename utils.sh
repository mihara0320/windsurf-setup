#!/usr/bin/env bash
# Shared helpers for setup.sh. Meant to be sourced, not executed.

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  local cmd="$1" hint="${2:-}"
  command -v "$cmd" >/dev/null 2>&1 || die "$cmd is required${hint:+ ($hint)}"
}

write_success_file() {
  local file="$1"
  echo "success" > "$file"
}

install_deps() {
  require_command pnpm "https://pnpm.io/installation"
  pnpm i -g @wise/ci-npm-lib@0.71.3
}
