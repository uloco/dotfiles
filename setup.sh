#!/usr/bin/env bash

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update

# Configure homebrew permissions to allow multiple users on MAC OSX.
# Any user from the admin group will be able to manage the homebrew and cask installation on the machine.
sudo chgrp -R admin $(brew --prefix)/*
sudo chmod -R g+w $(brew --prefix)/*
  
# allow admins to homebrew's local cache of formulae and source files
if [ -e /Library/Caches/Homebrew ]; then
  sudo chgrp -R admin /Library/Caches/Homebrew
  sudo chmod -R g+w /Library/Caches/Homebrew
fi

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# Install remaining software via brew bundle
brew bundle

# Stow configs
stow --adopt $(\ls -d */)
git restore .

# bat theme
bat cache --build

# neovim
# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"

# Links
cd "${HOME}"
ln -s "${HOME}/Library/Mobile Documents/com~apple~CloudDocs" iCloudDrive
ln -s "iCloudDrive/etc/.zsh-history"
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
defaults import com.apple.dock "$(pwd)/com.apple.dock.plist"

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
defaults delete com.apple.HIToolbox
defaults import com.apple.HIToolbox "$(pwd)/com.apple.HIToolbox.plist"

# Reboot
