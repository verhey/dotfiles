# path
typeset -U path
path+=(
  $PATH
  "/usr/local/sbin"
  "$HOME/go/bin"
)

# System/Apps
export EDITOR=vim
setopt histignorealldups
setopt histreduceblanks

# Aliases
source $HOME/.zshaliases
