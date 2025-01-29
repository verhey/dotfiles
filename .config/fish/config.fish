# Prompt/Theme
starship init fish | source
fish_config theme choose Nord

# Aliases
abbr -a gs "git status"
abbr -a gd "git diff -b -w"
abbr -a gds "git diff --staged -b -w"
abbr -a gdb "git diff develop...HEAD"
abbr -a gdbm "git diff main..HEAD"
abbr -a gb "git --no-pager branch -v"
abbr -a gcm "git switch main"
abbr -a cdc "cd $HOME/code"
abbr -a dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Envvars
set -x EDITOR nvim

# PATH
fish_add_path -g $HOME/go/bin
fish_add_path -g /opt/homebrew/bin

if type -q fzf
    fzf --fish | source
end

if test -f $HOME/.launchdarklyrc
    source $HOME/.launchdarklyrc
end

# autocompletes
uv generate-shell-completion fish | source
