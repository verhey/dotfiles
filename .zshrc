#### Theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#### System/Apps
# system configuration
export EDITOR=nano
export PATH="/usr/local/sbin:$PATH"

# brew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# pyenv-virtualenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv virtualenv-init - zsh)"

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
go env -w "GOPRIVATE=github.com/launchdarkly" || true

#### Secrets and Aliases
# secrets configuration
# source $HOME/.sample_secrets.env
# source $HOME/.secrets.env
source $HOME/.zshaliases

# SnowSQL
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

#### Oh My Zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
