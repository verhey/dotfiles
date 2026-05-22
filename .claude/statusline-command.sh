#!/bin/sh
# Claude Code status line — mirrors Starship default prompt style
# Receives JSON on stdin with session/context info

input=$(cat)

# Directory: use cwd from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$cwd" ] && cwd=$(pwd)
dir=$(basename "$cwd")

# Git branch (skip optional locks)
branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context usage (only shown after first API call)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build the status line
# Colors: cyan for dir, purple for git, yellow for model, dim for context
printf "\033[36m%s\033[0m" "$dir"

if [ -n "$branch" ]; then
  printf " \033[35m %s\033[0m" "$branch"
fi

if [ -n "$model" ]; then
  printf " \033[33m[%s]\033[0m" "$model"
fi

if [ -n "$used_pct" ]; then
  printf " \033[2mctx:%.0f%%\033[0m" "$used_pct"
fi
