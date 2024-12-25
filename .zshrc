# path
export PYENV_ROOT="$HOME/.pyenv"
typeset -U path
path+=(
  $PATH
  "/usr/local/sbin"
  "$PYENV_ROOT/bin"
  "$HOME/.rbenv/bin"
)

# brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# included because M1 and Intel homebrew differs
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# zellij
eval "$(zellij setup --generate-auto-start zsh)"

# Theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# System/Apps
export EDITOR=nvim
export CORRECT_IGNORE_FILE='.zsh_correctignore'
setopt correct
setopt histignorealldups
setopt histreduceblanks

# iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# pyenv configuration
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv virtualenv-init - zsh)"

# rbenv
eval "$(rbenv init -)"

# Work
LDRC=$HOME/.launchdarklyrc && test -f $LDRC && source $LDRC

# Aliases
source $HOME/.zshaliases

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
