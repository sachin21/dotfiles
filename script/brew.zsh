#!/usr/bin/env zsh

set -e

declare DOTFILES_PATH
declare REPOSITORIES
declare FORMULAS
declare APPLICATIONS
declare OS

DOTFILES_PATH="$HOME/dotfiles"
REPOSITORIES=$(cat "$DOTFILES_PATH/data/repositories.txt")
FORMULAS=$(cat "$DOTFILES_PATH/data/formulas.txt")
APPLICATIONS=$(cat "$DOTFILES_PATH/data/applications.txt")
OS="$OSTYPE"

# Load method for printing
. "$DOTFILES_PATH/etc/helpers"

# Check for os
function is_darwin() {
  [[ "$OS" == darwin* ]]
}

# Export paths for *brew
function export_paths() {
  if is_darwin; then
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
  else
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  fi
}

# Check for existence ruby
function check_for_ruby() {
  if command_exists ruby curl; then
    fail "  x [Error] Ruby or cURL are not installed"; return 1
  else
    message "  + Ruby and cURL found. alright let's go!"
  fi
}

# Check for existence brew command
function install_homebrew(){
  local installation_url="$1"

  if command_exists brew; then
    message "  + Homebrew found"
  else
    message "  + Installing Homebrew..."
    ruby -e "$(curl -fsSL "$installation_url")"
    message "  + Homebrew was successfully installed"
  fi
}

# Update Homebrew formulas
function update_homebrew() {
  ask "  + Do you want to update Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = "Y" ]; then
    message "  + Updating Homebrew"
    brew update
  fi
}

# Upgrade formulas
function upgrade_homebrew() {
  ask "  + Do you want to upgrade Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = 'Y' ]; then
    message "  + Upgrading Homebrew formulas"
    brew upgrade || return 0
  fi
}

# Tap repositories
function tap_repositories() {
  message "  + Tapping repositories..."

  for repository in $REPOSITORIES; do
    brew tap "$repository" || return 0
  done
}

# Install formulas
function install_formulas() {
  message "  + Installing formulas..."

  for formula in $FORMULAS; do
    brew install "$formula" || return 0
  done
}

# Install brew-cask
function install_formulas() {
  message "  + Installing Homebrew-cask..."

  brew install caskroom/cask/brew-cask || return 0
}

# Install Applications to /Applications
function install_osx_applications() {
  message "  + Installing OS X Application..."

  for application in $APPLICATIONS; do
    brew cask install --appdir="/Applications" "$application" || return 0
  done
}

# Create link for installed applications
function create_link() {
  message "  + Linking osx apps..."

  brew cask alfred link
}

# Remove outdated versions and archive file
function remove_caches() {
  message "  + Removing caches..."

  brew cleanup

  if [[ $OSTYPE == darwin* ]] && brew list | grep brew-cask > /dev/null 2>&1; then
    brew cask cleanup
  fi
}

function main() {
  check_for_ruby || return 1
  export_paths

  if is_darwin; then
    install_homebrew "https://raw.githubusercontent.com/Homebrew/install/master/install"
  else
    install_homebrew "https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install"
  fi

  upgrade_homebrew
  upgrade_homebrew
  tap_repositories
  install_formulas

  if is_darwin; then
    install_osx_applications
    create_link
  fi

  remove_caches
}

main
