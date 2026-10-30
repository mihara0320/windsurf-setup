#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=utils.sh
source "$SCRIPT_DIR/utils.sh"

readonly CASK="devin-desktop"
readonly INSTALL_RESULT_FILE="$HOME/.result.txt"
readonly RESULT_FILE="$HOME/test.txt"

print_usage() {
  cat <<USAGE
usage: $(basename "$0") [command]

commands:
  all       write the result file, then install (default)
  install   install the Windsurf CLI ($CASK cask)
  result    write $RESULT_FILE
  help      show this message
USAGE
}

install_windsurf_cli() {
  require_command brew "https://brew.sh"

  brew list --cask "$CASK" >/dev/null 2>&1 || brew install --cask "$CASK"

  install_deps
  write_success_file "$INSTALL_RESULT_FILE"
}

write_test_result() {
  write_success_file "$RESULT_FILE"
}

main() {
  case "${1:-all}" in
    all)
      write_test_result
      install_windsurf_cli
      ;;
    install)         install_windsurf_cli ;;
    result)          write_test_result ;;
    help|-h|--help)  print_usage ;;
    *)
      print_usage >&2
      exit 1
      ;;
  esac
}

main "$@"
