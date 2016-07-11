#!/usr/bin/env zsh

set -e

declare DOTFILES_PATH
declare OS

DOTFILES_PATH="$HOME/dotfiles"
NEEDED_PACKAGES="ruby curl"
OS="$OSTYPE"

# Load helpers
. "$DOTFILES_PATH/etc/helpers"

# Check for existence ruby
function check_for_ruby() {
  if command_exists $NEEDED_PACKAGES; then
    fail "  x [Error] Ruby and cURL are not installed"; return 1
  else
    message "  + Ruby is found. alright let's go!"
  fi
}

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
function update_formulas() {
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
    brew upgrade || true
  fi
}

# Tap repositories
function tap_repositories() {
  message "  + Tapping repositories..."

  for repository in $(cat "$DOTFILES_PATH/data/repositories.txt"); do
    brew tap "$repository" || true
  done
}

# Install formulas
function install_formulas() {
  message "  + Installing formulas..."

  for formula in $(cat "$DOTFILES_PATH/data/formulas.txt"); do
    brew install "$formula" || true
  done
}

# Install brew-cask
function install_brew-cask() {
  message "  + Installing Homebrew-cask..."

  brew tap caskroom/cask
  brew install cask
}

# Install Applications to /Applications
function install_osx_applications() {
  message "  + Installing OS X Application..."

  for application in $(cat "$DOTFILES_PATH/data/applications.txt"); do
    brew cask install $application || true
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

  if [[ $OSTYPE == darwin* ]] && brew list | grep -q brew-cask; then
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
  update_formulas
  tap_repositories
  install_formulas

  if is_darwin; then
    install_osx_applications
    create_link
  fi

  remove_caches
}

main
