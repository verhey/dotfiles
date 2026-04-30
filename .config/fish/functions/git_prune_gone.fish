function git_prune_gone --description 'Delete local branches whose upstream is gone'
    git fetch --prune
    for branch in (git for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads | string match -rg '^(\S+) \[gone\]$')
        git branch -D $branch
    end
end
