# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git colorize brew pyenv)
source $ZSH/oh-my-zsh.sh

export EDITOR=nano
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="/usr/local/sbin:$PATH"

# Aliases
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias cdyb='cd ~/yapta/business'
alias cdpr='cd ~/yapta/projects'
alias gs='git status'
alias gd='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias gds='git diff --staged --ignore-space-at-eol -b -w --ignore-blank-lines'
alias gdb='git diff develop...HEAD'
alias gdbm='git diff master..HEAD'
alias gb='git branch -v'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# pyenv bits
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
