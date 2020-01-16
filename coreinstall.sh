#!/bin/sh
#
if test ! $(which xcode-select); then
  echo "Install Xcode..."
  xcode-select --install
fi

if test ! $(which brew); then
  echo "Install Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Check Git version..."
git version

if test ! $(which git); then
  echo "Upgrading Git..."
  brew install git
  echo "export $PATH=/usr/local/Cellar:/usr/local/sbin:$PATH" >> ~/.bashrc
fi

echo "Verify Git version..."
git version

echo "Configure Git..."
touch .gitconfig
git config -l --global
git config --global user.name "< user-name >" # add github account
git config --global user.email "< email-id >" # add github email

echo "Check Git configuration..."
git config -l --global

echo "Ruby version..."
ruby -v

echo "Install Ruby..."
brew install ruby

echo "Check Gem Manager..."
gem -v

echo "Upgrade RubyGems..."
gem update --system

echo "Enable no-documentation install for Gems..."
echo "gem: --no-document" >> ~/.gemrc

brew doctor

brew tap homebrew/cask

apps=(
  1password
  android-file-transfer
  docker
  free-download-manager
  firefox
  github
  handbrake
  imageoptim
  inkscape
  iterm2
  the-unarchiver
  tutanota
  tor-browser
  visual-studio-code
  vlc
  xmind
  xquartz
)

echo "Installing Applications..."
brew cask install --appdir="/Applications" ${apps[@]}

brewapps=(
  ffmpeg
  youtube-dl
  mkvtoolnix
  mas
)

echo "Installing Brew Apps..."
brew install ${brewapps[@]}

echo ""
echo "Enter AppleID to signin to Mac App Store.."
read -p "AppleID: " APPLEID # add Apple ID here

mas signin $APPLEID

masapps=(
  880001334 # Reeder (3.2.3)
  985367838 # Microsoft Outlook (16.32)
  823766827 # OneDrive (19.192.0926)
  497799835 # Xcode (11.3)
  784801555 # Microsoft OneNote (16.32)
  462062816 # Microsoft PowerPoint (16.32)
  462054704 # Microsoft Word (16.32)
  462058435 # Microsoft Excel (16.32)
)

mas install ${masapps[@]}

echo "Upgrading installed brews..."

brew upgrade

echo "Removing all the cask downloads..."
brew cask cleanup --prune 0

echo "Remove downloads for installed formulae..."
rm -rf $(brew --cache)

brew cleanup --prune 0
brew doctor

echo "macOS configs..."

defaults write "NSGlobalDomain" "AppleShowAllExtensions" -bool TRUE
defaults write "com.apple.desktopservices" "DSDontWriteNetworkStores" -bool TRUE

defaults write "com.apple.finder" "AppleShowAllFiles" -bool TRUE
defaults write "com.apple.finder" "ShowStatusBar" -bool TRUE
defaults write "com.apple.finder" "ShowPathbar" -bool TRUE
defaults write "com.apple.finder" "ShowHardDrivesOnDesktop" -bool TRUE
defaults write "com.apple.finder" "ShowExternalHardDrivesOnDesktop" -bool TRUE
defaults write "com.apple.finder" "ShowRecentTags" -bool FALSE
defaults write "com.apple.finder" "DownloadsFolderListViewSettingsVersion" -bool TRUE
defaults write "com.apple.finder" "NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow" -bool TRUE
defaults write "com.apple.finder" "FXPreferredViewStyle" -string "clmv"
defaults write "com.apple.finder" "FXDefaultSearchScope" -string "SCcf"
defaults write "com.apple.finder" "NewWindowTarget" -string "PfLo"
defaults write "com.apple.finder" "NewWindowTargetPath" -string "file:///Users/kumbhar-vivek/Downloads/"

defaults write "com.apple.dock" "tilesize" -int 30
defaults write "com.apple.dock" "show-recents" -bool FALSE
defaults write "com.apple.dock" "autohide" -bool FALSE
defaults write "com.apple.dock" "show-process-indicators" -bool TRUE
defaults write "com.apple.dock" "magnification" -bool TRUE
defaults write "com.apple.dock" "launchanim" -bool TRUE
defaults write "com.apple.dock" "minimize-to-application" -bool TRUE
defaults write "com.apple.dock" "largesize" -int 128
defaults write "com.apple.dock" "mineffect" -string "scale"

defaults write "com.apple.AppleMultitouchTrackpad" "TrackpadThreeFingerDrag" -bool TRUE
defaults write "com.apple.menuextra.battery" "ShowPercent" -bool TRUE
defaults write "com.apple.menuextra.clock" "DateFormat" -string "EEE d MMM  h:mm:ss a"

/usr/libexec/PlistBuddy -c "set :DesktopViewSettings:IconViewSettings:iconSize 40" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set :DesktopViewSettings:IconViewSettings:showItemInfo TRUE" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set :DesktopViewSettings:IconViewSettings:labelOnBottom FALSE" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set :DesktopViewSettings:IconViewSettings:showIconPreview TRUE" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 40" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo TRUE" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showIconPreview TRUE" ~/Library/Preferences/com.apple.finder.plist

sudo defaults write /Library/Preferences/com.apple.commerce "AutoUpdate" -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate "AutomaticallyInstallMacOSUpdates" -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate "AutomaticCheckEnabled" -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate "AutomaticDownload" -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate "CriticalUpdateInstall" -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate "ConfigDataInstall" -bool TRUE

echo "Resetting LaunchPad..."
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock
