brew update     # download app updated formulas
brew upgrade
brew outdated   # what’s old?
brew cleanup	--prune 0 # cleanup cask
brew doctor	# verify brew
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock
