#!/usr/bin/env sh

set -e

DOTFILES_PATH="$HOME/dotfiles"
REPOSITORIES=`cat $DOTFILES_PATH/data/repositories.txt`
FORMULAS=`cat $DOTFILES_PATH/data/formulas.txt`

# Load method for printing
. $DOTFILES_PATH/etc/print_helper

# Check exist brew command
install_homebrew(){
  if command_exists brew; then
    message "  + Linuxbrew found"
  else
    message "  + Installing Linuxbrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
    message "  + Linuxbrew was successfully installed"
  fi
}

# Update Homebrew formulas
update_homebrew(){
  ask "  + Do you want to update Homebrew? [Y/n]:" && read flag

  if [ $flag = 'y' -o $flag = 'Y' ]; then
    message "  + Updating Homebrew"
    brew update
  fi
}

# Upgrade formulas
upgrade_homebrew(){
  ask "  + Do you want to upgrade Homebrew? [Y/n]:" && read flag

  if [ $flag = 'y' -o $flag = 'Y' ]; then
    message "  + Upgrading Homebrew formulas"
    brew upgrade
  fi
}

# Tap repositories
tap_repositories(){
  message "  + Tapping repositories..."

  for repository in $REPOSITORIES; do
    brew tap $repository || true
  done
}

# Install formulas
install_formulas(){
  message "  + Installing formulas..."

  for formula in $FORMULAS; do
    brew install $formula || true
  done
}

# Remove outdated versions and archive file
remove_caches(){
  message "  + Removing caches..."

  brew cleanup
}

main(){
  install_homebrew
  upgrade_homebrew
  upgrade_homebrew
  tap_repositories
  install_formulas
  remove_caches

  exit 0
}

main
