#!/usr/bin/env sh

set -e

DOTFILES_PATH="$HOME/dotfiles"
REPOSITORIES=`cat $DOTFILES_PATH/data/repositories.txt`
FORMULAS=`cat $DOTFILES_PATH/data/formulas.txt`

# Loading method for printing
. $DOTFILES_PATH/etc/print_helper

# Check exist brew command
if type brew > /dev/null 2>&1; then
  message "  + Homebrew found"
else
  message "  + Installing linuxbrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
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

message "  + Tapping repositories..."

for repository in $REPOSITORIES; do
  brew tap $repository || true
done

message "  + Installing formulas..."

for formula in $FORMULAS; do
  brew install $formula || true
done

# Remove outdated versions and archive file
message "  + Cleaning caches..."
brew cleanup

exit 0
