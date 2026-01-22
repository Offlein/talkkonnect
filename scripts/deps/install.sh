#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  source /etc/os-release
else
  echo "Cannot detect OS (missing /etc/os-release)." >&2
  exit 1
fi

case "${ID:-}" in
  arch|manjaro|endeavouros)
    exec bash "$ROOT/scripts/deps/arch.sh"
    ;;
  debian|raspbian|ubuntu)
    exec bash "$ROOT/scripts/deps/debian.sh"
    ;;
  *)
    echo "Unsupported distro ID='${ID:-unknown}'."
    echo "Run one of:"
    echo "  scripts/deps/debian.sh"
    echo "  scripts/deps/arch.sh"
    exit 2
    ;;
esac
