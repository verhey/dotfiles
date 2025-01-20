# dotfiles

This is a project created for syncing as much of my MacOS dev machine configuration as possible

## Prerequisites

* git
  * If you intend on checking out this repo using SSH, an SSH key configured and added to your github
* On MacOS, [brew](https://brew.sh/) for package installation

## Installation - `dotfiles`

* This is based off of Atlassian's [bare dotfile repo](https://www.atlassian.com/git/tutorials/dotfiles) implementation
* Open a shell, and bare clone this repo into the `.dotfiles` directory
  * `git clone --bare git@github.com:verhey/dotfiles.git $HOME/.dotfiles`
* Define the following alias in your shell:
  * `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
  * or `abbr -a dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"` if using fish
* Checkout the content from the bare repo into your home folder:
  * `dotfiles checkout`
  * If this fails, delete any dotfiles that may conflict, or back them up
  * Try `dotfiles checkout` again, and you should see the files in the root of this repo end up in your home dir
* To make `dotfiles status` output useful, set local config for this repo to ignore untracked files (as in, the rest of your home dir)
  * `dotfiles config --local status.showUntrackedFiles no`

## Usage

* If you (or another application has modified a dotfile) and you want to update it here, the `dotfiles` alias you set up in previous steps works just like `git` does.
  * Your `status` command is somewhat nerfed, because you don't want to be tracking every file in your home directory, but you can still do the following:

## Installation - Brewfiles and MacOS setup

* From the `install/macos` directory:
  * `brew bundle` to install contents of `Brewfile`
  * `zsh configure_macos` to configure MacOS-specific settings
    * This is WIP-y, Apple seems to change what works and what doesn't with every MacOS version
* I've been trying out fish - to set it as the default system shell do:
  * `sudo echo /opt/homebrew/bin/fish >> /etc/shells`
  * `chsh -s /opt/homebrew/bin/fish`
* Someday the `zsh` pieces of this repo might disappear, or they'll get simpler
* Probably reboot
