#!/usr/bin/env bash
set -euo pipefail

allows=(
  'awk'
  'cat'
  'diff'
  'du'
  'fd'
  'file'
  'find'
  'head'
  'jq'
  'ls'
  'grep'
  'rg'
  'sed'
  'stat'
  'tail'
  'wc'
  'which'
  'gh issue list'
  'gh issue status'
  'gh issue view'
  'gh pr diff'
  'gh pr list'
  'gh pr status'
  'gh pr view'
  'gh pr checks'
  'gh run list'
  'gh run view'
  'gh search'
  'git status'
  'git diff'
  'git log'
)
denies=(
  'curl'
  'wget'
  'nc'
  'ssh'
  'aws'
  'terraform'
)
sensitive_paths=(
  "$HOME/.ssh/*"
  "$HOME/.aws/*"
  "$HOME/.kube/*"
  "$HOME/.npmrc"
  "$HOME/.git-credentials"
  "$HOME/.config/gh/*"
  "$HOME/.config/fish/work.fish"
  '*.env'
  '*/.env'
  '.env.*'
  '*/.env.*'
  '*ngrok.yml'
)

matches_command() {
  local command="$1"
  local configured_command="$2"

  [[ "$command" == "$configured_command" || "$command" == "$configured_command"[[:space:]]* ]]
}

contains_command_chaining() {
  local command="$1"

  [[ "$command" =~ [\;\&\|\`\$\<\>] ]]
}

contains_sudo() {
  local command="$1"

  [[ "$command" =~ (^|[[:space:]])sudo([[:space:]]|$) ]]
}

command="${CRUSH_TOOL_INPUT_COMMAND:-}"
if contains_sudo "$command"; then
  printf 'Command is blocked because it uses sudo: %s\n' "$command" >&2
  exit 2
fi

for denied_command in "${denies[@]}"; do
  if matches_command "$command" "$denied_command"; then
    printf 'Command is blocked: %s\n' "$command" >&2
    exit 2
  fi
done

if ! contains_command_chaining "$command"; then
  for allowed_command in "${allows[@]}"; do
    if matches_command "$command" "$allowed_command"; then
      printf '{"decision":"allow"}\n'
      exit 0
    fi
  done
fi

path="${CRUSH_TOOL_INPUT_FILE_PATH:-}"
for sensitive_path in "${sensitive_paths[@]}"; do
  if [[ "$path" == $sensitive_path ]]; then
    printf 'Access to sensitive path is blocked: %s\n' "$path" >&2
    exit 2
  fi
done

# An empty decision preserves Crush's normal permission prompt.
printf '{}\n'
