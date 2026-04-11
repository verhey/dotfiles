# path
typeset -U path
path+=(
  $PATH
  "/usr/local/sbin"
  "$HOME/go/bin"
)

# brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# included because M1 and Intel homebrew differs
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# System/Apps
export EDITOR=nvim
setopt histignorealldups
setopt histreduceblanks

# Aliases
source $HOME/.zshaliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
