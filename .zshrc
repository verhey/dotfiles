# path
export PYENV_ROOT="$HOME/.pyenv"
typeset -U path
path+=(
  $PATH
  "/usr/local/sbin"
  "$PYENV_ROOT/bin"
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
export CORRECT_IGNORE_FILE='.zsh_correctignore'
setopt correct
setopt histignorealldups
setopt histreduceblanks

# pyenv configuration
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv virtualenv-init - zsh)"

# Work
LDRC=$HOME/.launchdarklyrc && test -f $LDRC && source $LDRC

# Aliases
source $HOME/.zshaliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
