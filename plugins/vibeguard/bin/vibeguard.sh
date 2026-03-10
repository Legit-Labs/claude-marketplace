#!/bin/sh
# Launcher script that detects OS/arch and runs the correct vibeguard binary.
# Also sets LEGIT_CLI_PATH to the bundled legit-cli binary for the current platform.
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$ARCH" in
  x86_64)  ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  arm64)   ARCH="arm64" ;;
esac

BINARY="${SCRIPT_DIR}/vibeguard-${OS}-${ARCH}"
LEGIT_BINARY="${SCRIPT_DIR}/legit-${OS}-${ARCH}"

if [ ! -f "$BINARY" ]; then
  echo "Unsupported platform: ${OS}-${ARCH}" >&2
  exit 1
fi

# Set LEGIT_CLI_PATH to the bundled legit binary if not already set
if [ -z "${LEGIT_CLI_PATH:-}" ] && [ -f "$LEGIT_BINARY" ]; then
  export LEGIT_CLI_PATH="$LEGIT_BINARY"
fi

exec "$BINARY" "$@"
