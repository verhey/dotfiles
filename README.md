# dotfiles

This is a project created for syncing as much of my MacOS dev machine configuration as possible

## Prerequisites

* git
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

* If you want to update a dotfile here, the `dotfiles` alias you set up in previous steps works just like `git` does.
  * Your `status` command is somewhat nerfed though, because you don't want to be tracking every file in your home directory

## Installation - Brew and Fish

* From the `install/macos` directory:
  * `brew bundle` to install contents of `Brewfile`
* Set Fish as the default system shell via:
  * `sudo echo $(which fish) >> /etc/shells`
  * `chsh -s $(which fish)`
* Probably reboot

## MacOS Behavior Tweaks

I used to keep a script of various commands I'd run on new machines for things like key repeat, etc. This is a constant moving target with MacOS updates, but these are things that have worked in the past:

| Setting | Command |
|---------|---------|
| Save to disk (not to iCloud) by default | `defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false` |
| Disable the warning when changing a file extension | `defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false` |
| Disable automatic capitalization | `defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false` |
| Disable smart dashes | `defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false` |
| Disable automatic period substitution | `defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false` |
| Disable smart quotes | `defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false` |
| Disable auto-correct | `defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false` |
| Set a fast keyboard repeat rate | `defaults write NSGlobalDomain KeyRepeat -int 1 && defaults write NSGlobalDomain InitialKeyRepeat -int 10` |
| Enable key repeating for an application | `defaults write TODO_REPLACE_WITH_YOUR_APPLICATION ApplePressAndHoldEnabled -bool false` |
| Use plain text mode for new TextEdit documents | `defaults write com.apple.TextEdit RichText -int 0` |
| Open and save files as UTF-8 in TextEdit | `defaults write com.apple.TextEdit PlainTextEncoding -int 4 && defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4` |
| Show the main window when launching Activity Monitor | `defaults write com.apple.ActivityMonitor OpenMainWindow -bool true` |
| Visualize CPU usage in the Activity Monitor Dock icon | `defaults write com.apple.ActivityMonitor IconType -int 5` |
| Show all processes in Activity Monitor | `defaults write com.apple.ActivityMonitor ShowCategory -int 0` |
| Sort Activity Monitor results by CPU usage | `defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage" && defaults write com.apple.ActivityMonitor SortDirection -int 0` |
| Make Dock icons of hidden applications translucent | `defaults write com.apple.dock showhidden -bool true` |
| Don't show recent applications in Dock | `defaults write com.apple.dock show-recents -bool false` |
| Allow quitting Finder via Cmd+Q | `defaults write com.apple.finder QuitMenuItem -bool true` |
| Show hidden files by default in Finder | `defaults write com.apple.finder AppleShowAllFiles -bool true` |
| Show all filename extensions in Finder | `defaults write NSGlobalDomain AppleShowAllExtensions -bool true` |
| Show status bar in Finder | `defaults write com.apple.finder ShowStatusBar -bool true` |
| Show path bar in Finder | `defaults write com.apple.finder ShowPathbar -bool true` |
| Avoid creating .DS_Store files on network or USB volumes | `defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true` |
| Use list view in all Finder windows by default | `defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"` |
| Show the ~/Library folder | `chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library` |
| Show the /Volumes folder | `sudo chflags nohidden /Volumes` |
