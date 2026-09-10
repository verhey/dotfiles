#!/usr/bin/env bash
set -euo pipefail

path="${CRUSH_TOOL_INPUT_FILE_PATH:-}"
case "$path" in
  "$HOME"/.ssh/*|"$HOME"/.aws/*|"$HOME"/.kube/*|"$HOME"/.npmrc|\
  "$HOME"/.git-credentials|"$HOME"/.config/gh/*|*.env|*/.env|.env.*|*/.env.*)
    printf 'Access to sensitive path is blocked: %s\n' "$path" >&2
    exit 2
    ;;
esac
