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
abbr -a nvm fnm

# Envvars
set -x EDITOR hx

# PATH
fish_add_path -g $HOME/go/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/sbin
fish_add_path -g $HOME/.local/bin

# fnm (Node.js version manager)
fnm env --use-on-cd --shell fish | source

# Work (not in version control)
if test -f ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end

if type -q fzf
    fzf --fish | source
end

# autocompletes
uv generate-shell-completion fish | source

# pnpm
set -gx PNPM_HOME /Users/dean/Library/pnpm
if not string match -q -- "$PNPM_HOME/bin" $PATH
    set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
