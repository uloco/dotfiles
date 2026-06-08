#!/usr/bin/env bash

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# install fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# Rosetta 2 (required for some mas apps)
sudo softwareupdate --install-rosetta --agree-to-license

# Install remaining software via brew bundle
brew bundle

# Xcode
xcodes install --latest --experimental-unxip
sudo xcode-select -s /Applications/Xcode.app

# Stow configs
stow --adopt $(\ls -d */)
git restore .

# bat theme
bat cache --build

# Links
ln -sf "${HOME}/Library/Mobile Documents/com~apple~CloudDocs" "${HOME}/iCloudDrive"
ln -sf "${HOME}/iCloudDrive/etc/.zsh-history" "${HOME}/.zsh-history"

# Defaults

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# disable .ds_store file creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

killall Finder

# Trackpad
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# Text Input - disable all auto-corrections
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Scrollbars - always visible
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Click wallpaper to show desktop - off
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Safari
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Keyrepeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Dock
defaults delete com.apple.dock
defaults import com.apple.dock com.apple.dock.plist

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
defaults import com.apple.HIToolbox com.apple.HIToolbox.plist

# Moom
defaults delete com.manytricks.Moom
defaults import com.manytricks.Moom com.manytricks.Moom.plist

# Preferences
defaults delete com.lwouis.alt-tab-macos
defaults import com.lwouis.alt-tab-macos com.lwouis.alt-tab-macos.plist

defaults delete me.guillaumeb.MonitorControl
defaults import me.guillaumeb.MonitorControl me.guillaumeb.MonitorControl.plist

# Amphetamine
defaults delete com.if.Amphetamine
defaults import com.if.Amphetamine com.if.Amphetamine.plist

# Flow
defaults delete design.yugen.Flow
defaults import design.yugen.Flow design.yugen.Flow.plist

# ColorSlurp
defaults delete com.IdeaPunch.ColorSlurp
defaults import com.IdeaPunch.ColorSlurp com.IdeaPunch.ColorSlurp.plist

# TomatoBar
defaults delete com.github.ivoronin.TomatoBar
defaults import com.github.ivoronin.TomatoBar com.github.ivoronin.TomatoBar.plist

# Wallpaper
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"${HOME}"'/Library/Mobile Documents/com~apple~CloudDocs/Pictures/colorful-patches.heic"'

# Reboot
