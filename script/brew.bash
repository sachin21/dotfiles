#!/usr/bin/env bash

set -e

declare -r DOTFILES_PATH
declare -r REPOSITORIES
declare -r FORMULAS
declare -r APPLICATIONS
declare -r OS

DOTFILES_PATH="$HOME/dotfiles"
REPOSITORIES=$(cat "$DOTFILES_PATH/data/repositories.txt")
FORMULAS=$(cat "$DOTFILES_PATH/data/formulas.txt")
APPLICATIONS=$(cat "$DOTFILES_PATH/data/apps.txt")
OS="$(uname)"

# Load method for printing
. "$DOTFILES_PATH/etc/helpers"

# Checking exists ruby
check_ruby(){
  if command_exists ruby; then
    fail "  x [Error] Ruby is not installed"
    return 1
  else
    message "  + Ruby found. alright let's go!"
  fi
}

# Checking exists brew command
install_homebrew(){
  local installation_url=$1

  if command_exists brew; then
    message "  + Homebrew found"
  else
    message "  + Installing Homebrew..."
    ruby -e "$(curl -fsSL "$installation_url")"
    message "  + Homebrew was successfully installed"
  fi
}

# Update Homebrew formulas
update_homebrew(){
  ask "  + Do you want to update Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = "Y" ]; then
    message "  + Updating Homebrew"
    brew update
  fi
}

# Upgrade formulas
upgrade_homebrew(){
  ask "  + Do you want to upgrade Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = 'Y' ]; then
    message "  + Upgrading Homebrew formulas"
    brew upgrade
  fi
}

# Tap repositories
tap_repositories(){
  message "  + Tapping repositories..."

  for repository in $REPOSITORIES; do
    brew tap "$repository" || true
  done
}

# Install formulas
install_formulas(){
  message "  + Installing formulas..."

  for formula in $FORMULAS; do
    brew install "$formula" || true
  done
}

# Install brew-cask
install_formulas(){
  message "  + Installing Homebrew-cask..."

  brew install caskroom/cask/brew-cask || true
}

# Install Applications to /Applications
install_osx_applications(){
  message "  + Installing OS X Application..."

  for application in $APPLICATIONS; do
    brew cask install --appdir="/Applications" "$application" || true
  done
}

# Create link for installed applications
create_link(){
  message "  + Linking osx apps..."

  brew cask alfred link
}

# Remove outdated versions and archive file
remove_caches(){
  message "  + Removing caches..."

  brew cleanup

  if [ "$OS" = "Darwin" ] && brew list | grep brew-cask > /dev/null 2>&1; then
    brew cask cleanup
  fi
}

main(){
  if [ "$OS" = "Darwin" ]; then
    install_homebrew "https://raw.githubusercontent.com/Homebrew/install/master/install"
  else
    install_homebrew "https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install"
  fi

  upgrade_homebrew
  upgrade_homebrew
  tap_repositories
  install_formulas

  if [ "$OS" = "Darwin" ]; then
    install_osx_applications
    create_link
  fi

  remove_caches

  exit 0
}

main
