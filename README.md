# dotfiles

This is a project created for syncing as much of my OSX dev machine configuration as possible across machines

## Prerequisites

* git, and this repository checked out locally
  * I would recommend checking it out to `~/.dotfiles`
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

## Installation - Brewfiles and OSX setup

* From the `install` directory:
  * `bash macos` to configure OSX-specific settings
  * `brew bundle` to install contents of `Brewfile`
