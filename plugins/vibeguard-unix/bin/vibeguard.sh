#!/bin/sh
# Unix launcher for the VibeGuard plugin (Linux + macOS).
# Detects OS/arch, exposes LEGIT_CLI_PATH, and passes auth/ping/logout through
# to the bundled legit binary so customers have a runnable command from inside
# the plugin tree (no `legit` on $PATH required).
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

if [ -z "${LEGIT_CLI_PATH:-}" ] && [ -f "$LEGIT_BINARY" ]; then
  export LEGIT_CLI_PATH="$LEGIT_BINARY"
fi

# Passthrough for known legit-cli subcommands.
case "${1:-}" in
  auth|ping|logout)
    if [ ! -f "$LEGIT_BINARY" ]; then
      echo "Bundled legit binary not found for ${OS}-${ARCH}" >&2
      exit 1
    fi
    exec "$LEGIT_BINARY" "$@"
    ;;
esac

exec "$BINARY" "$@"
