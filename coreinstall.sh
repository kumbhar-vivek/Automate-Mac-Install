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
git config --global user.email < github-email > # add github email

echo "Check Git configuration..."
git config -l --global

echo "Ruby version..."
ruby -v

echo "Install Ruby..."
brew install ruby

# echo "Linking Ruby..."
# brew unlink ruby && brew link ruby

echo "Check Gem Manager..."
gem -v

echo "Upgrade RubyGems..."
gem update --system

echo "Enable no-documentation install for Gems..."
echo "gem: --no-document" >> ~/.gemrc

brew doctor

brew tap homebrew/cask-fonts

fonts=(
  font-ibm-plex
  font-fira-code
)

echo "Install Fonts..."
brew cask install ${fonts[@]}

brew tap home-brew/cask-cask

apps=(
  android-file-transfer
  atom
  box-drive
  docker
  free-download-manager
  freemind
  firefox
  github
  google-backup-and-sync
  google-chrome
  handbrake
  imageoptim
  inkscape
  iterm2
  slack
  vlc
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
read -p " AppleID (< apple_id >): " APPLEID # add Apple ID here

mas signin $APPLEID

masapps=(
  880001334 # Reeder (3.2.1)
  1147396723 # WhatsApp (0.3.1242)
  425424353 # The Unarchiver (4.0.0)
)

mas install ${masapps[@]}

echo "Upgrading installed brews..."

brew update

echo "Removing all the cask downloads..."
brew cask cleanup --prune 0

echo "Remove downloads for installed formulae..."
rm -rf $(brew --cache)

brew cleanup --prune 0
brew doctor

# echo "Add brewski to .bash_profile..."
# touch ~/.bash_profile
# echo "export PATH=/usr/local/opt/ruby/bin:$PATH" >> ~/.bash_profile
# echo "alias brewski='mas outdated && mas upgrade && brew update && brew upgrade && brew cask upgrade && brew cleanup --prune 0; brew doctor'" >> ~/.bash_profile

echo "Install Atom packages..."
apm install --packages-file ~/Documents/atomConfig/atom-packages.txt
cp -f ~/Documents/atomConfig/config.cson ~/.atom/config.cson
cp -f ~/Documents/atomConfig/styles.less ~/.atom/styles.less

echo "Disable .DS_Store and ._ file on Network or USB..."
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

echo "Show hidden files..."
defaults write com.apple.finder AppleShowAllFiles -bool TRUE

echo "Resetting LaunchPad..."
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock
