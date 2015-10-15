#!/usr/bin/env sh

set -e

DOTFILES_PATH="$HOME/dotfiles"
REPOSITORIES=`cat $DOTFILES_PATH/data/repositories.txt`
FORMULAS=`cat $DOTFILES_PATH/data/formulas.txt`
APPLICATIONS=`cat $DOTFILES_PATH/data/apps.txt`

# Load method for printing
. $DOTFILES_PATH/etc/print_helper

# Check exist brew command
if type brew > /dev/null 2>&1; then
  message "  + Homebrew found"
else
  message "  + Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  message "  + Homebrew was successfully installed"
fi

# Update Homebrew formulas
ask "  + Do you want to update Homebrew? [Y/n]:" && read flag

if [ $flag = 'y' -o $flag = 'Y' ]; then
  message "  + Updating Homebrew"
  brew update
fi

# Upgrade formulas
ask "  + Do you want to upgrade Homebrew? [Y/n]:" && read flag

if [ $flag = 'y' -o $flag = 'Y' ]; then
  message "  + Upgrading Homebrew formulas"
  brew upgrade
fi

# Tap repositories
message "  + Tapping repositories..."

for repository in $REPOSITORIES; do
  brew tap $repository || true
done

# Install formulas
message "  + Installing formulas..."

for formula in $FORMULAS; do
  brew install $formula || true
done

# Install brew-cask
message "  + Installing Homebrew-cask..."

brew install caskroom/cask/brew-cask || true

# Install Applications to /Applications
message "  + Installing OS X Application..."

for application in $APPLICATIONS; do
  brew cask install --appdir="/Applications" $application || true
done

# Create link for installed applications
message "  + Linking osx apps..."
brew cask alfred link

# Remove outdated versions and archive file
message "  + Cleaning caches..."

brew cleanup
brew cask cleanup

exit 0
