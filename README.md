# dotfiles

This is a project created for syncing as much of my MacOS dev machine configuration as possible across machines

## Prerequisites

* git
  * If you intend on checking out this repo using SSH, an SSH key configured and added to your github
* On MacOS, [brew](https://brew.sh/) for package installation

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
* To make `dotfiles status` output useful, set local config for this repo to ignore untracked files (as in, the rest of your home dir)
  * `dotfiles config --local status.showUntrackedFiles no`

## Usage

* If you (or another application has modified a dotfile) and you want to update it here, the `dotfiles` alias you set up in previous steps works just like `git` does.
  * Your `status` command is somewhat nerfed, because you don't want to be tracking every file in your home directory, but you can still do the following:
    * `dotfiles add <your_file>` to stage a change
    * `dotfiles commit -m "your_message"` to commit that change
    * `dotfiles checkout -- <your_file>` to revert a change to a file
    * `dotfiles diff` or `dotfiles diff --staged` to view changes to your files
    * `dotfiles push` or `dotfiles pull` to sync your local copy with remote changes

## Installation - Brewfiles and MacOS setup

* From the `install/macos` directory:
  * `zsh configure_macos` to configure MacOS-specific settings
    * This is WIP-y, Apple seems to change what works and what doesn't with every MacOS version
  * `brew bundle` to install contents of `Brewfile`
  * `zsh zshsetup` to install `oh-my-zsh`, a few plugins, and get yourself up to date with what the checked in `.zshrc` is expecting
    * If you are encountering errors in the shell after cloning this repo, make sure you've run this script
  * [Manually install](https://github.com/romkatv/powerlevel10k#fonts) :( the recommended fonts for the `powerlevel10k` zsh theme
    * If you have any suggestions on how to do this programmatically, let me know!
  * Manually doubleclick and install `install/SolarizedDarkPatched.terminal` to get your Terminal working as `.zshrc` and `.p10k.zsh` expect

## Installation - Ubuntu (WSL)

* Note - this has not been tested on regular old Ubuntu, but I see no reason it wouldn't work. Just skip the part about copying the `wsl.conf` file since it's WSL-specific
* From the `install` directory:
  * Copy the Windows Subsystem for Linux (WSL) config file to `/etc/.`
    * `cp ubuntu/wsl.conf /etc/wsl.conf`
  * Run `ubuntu/configure_ubuntu` and let it do its thing
  * From there you'll need to reboot, and then you should be able to run `zsh zshsetup` located in the `install/` directory
* Optional - Windows Terminal Setup
  * Install the Windows Terminal from the Microsoft Store
  * Install the MesloLGF fonts manually to your *windows* installation (you can find their .ttf links in `install/ubuntu/configure_ubuntu`
  * There is a profile for Windows Terminal included in `install/ubuntu/windows_terminal.json`
  * This can be configured by copying to the settings directory windows terminal uses, which is at the time of writing this:
    * `C:\Users\ME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
    * This is very likely to change, however, so I would recommend going via the UI to Preferences > Open JSON File and then just copying the contents
