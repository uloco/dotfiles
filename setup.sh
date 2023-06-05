#!/usr/bin/env bash

# Stow configs
stow --adopt $(\ls -d */)
git restore .

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install remaining software via brew bundle
brew bundle

# Links
cd ${HOME}
ln -s "/Users/uloco/Library/Mobile Documents/com~apple~CloudDocs" iCloudDrive
ln -s "iCloudDrive/etc/.zsh-history"
ln -s "iCloudDrive/autojump/autojump.txt"
cd -

# Defaults

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true 
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

killall Finder

# Keyrepeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Dock
# defaults write com.apple.dock tilesize -float 42
# defaults write com.apple.dock mineffect scale
# defaults write com.apple.dock magnification -bool false
# defaults write com.apple.dock autohide -bool true
# defaults write com.apple.dock autohide-time-modifier -float 0.12
# defaults write com.apple.Dock autohide-delay -float 0.05

# defaults write com.apple.dock mru-spaces -bool false
defaults delete com.apple.dock
defaults import com.apple.dock "$(pwd)"/com.apple.dock.plist

killall Dock

# Menubar
# Date & Time
defaults write com.apple.menuextra.clock ShowDate -int 1
defaults write com.apple.menuextra.clock Show24Hour -int 1
defaults write com.apple.menuextra.clock ShowDayOfWeek -int 1

# Xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true

# Keyboard
# german nodeadkeys
cp ~/iCloudDrive/German_NoDeadKeys.bundle "~/Library/Keyboard Layouts/"
defaults delete com.apple.HIToolbox
defaults import com.apple.HIToolbox "$(pwd)"/com.apple.HIToolbox.plist

# Reboot
