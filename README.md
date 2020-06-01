# dotfiles

This is a project created for syncing as much of my OSX dev machine configuration as possible across machines

## Prerequisites

* git, and this repository checked out locally
  * I would recommend checking it out to `~/.dotfiles`
    * If you choose to check it out elsewhere, note that you will need to modify the commands below and in `install/` scripts to point to your preferred directory
* [brew](https://brew.sh/) for package installation
* If you intend on checking out this repo using SSH, an SSH key configured and added to your github

## Installation - `dotfiles`

* This is based off of Atlassian's [bare dotfile repo](https://www.atlassian.com/git/tutorials/dotfiles) implementation
* Open a shell, and bare clone this repo into the `.dotfiles` directory
  * `git clone --bare git@github.com:verhey/dotfiles.git $HOME/.dotfiles`
    * I used SSH (meaning you'd need a SSH key setup before), but use https if you'd rather
* Define the following alias in your shell: 
  * `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
* Checkout the content from the bare repo into your home folder:
  * `dotfiles checkout`
  * If this fails, delete any dotfiles that may conflict, or back them up
  * Try `dotfiles checkout` again, and you should see the files in the root of this repo end up in your home dir
* To make `git status` output useful, set local config for this repo to ignore untracked files (as in, the rest of your home dir)
  * `dotfiles config --local status.showUntrackedFiles no`

## Usage

* If you (or another application has modified a dotfile) and you want to update it here, the `dotfiles` alias you set up in previous steps works just like `git` does. 
  * Your `status` command is somewhat nerfed, because you don't want to be tracking every file in your home directory, but you can still do the following: 
    * `dotfiles add <your_file>` to stage a change
    * `dotfiles commit -m "your_message"` to commit that change
    * `dotfiles checkout -- <your_file>` to revert a change to a file
    * `dotfiles diff` or `dotfiles diff --staged` to view changes to your files
    * `dotfiles push` or `dotfiles pull` to sync your local copy with remote changes

## Installation - Brewfiles and OSX setup

* From the `install` directory:
  * `bash macos` to configure OSX-specific settings
    * This is WIP-y, Apple seems to change what works and what doesn't with every OSX version
  * `brew bundle` to install contents of `Brewfile`
  * `zsh zshsetup` to install `oh-my-zsh`, a few plugins, and get yourself up to date with what the checked in `.zshrc` is expecting
    * If you are encountering errors in the shell after cloning this repo, make sure you've run this script
  * [Manually install](https://github.com/romkatv/powerlevel10k#fonts) :( the recommended fonts for the `powerlevel10k` zsh theme
    * If you have any suggestions on how to do this programmatically, let me know!
  * Manually doubleclick and install `install/SolarizedDarkPatched.terminal` to get your Terminal working as `.zshrc` and `.p10k.zsh` expect
