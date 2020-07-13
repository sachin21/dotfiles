#!/usr/bin/env zsh

declare DOTFILES_PATH
declare OS

DOTFILES_PATH="$HOME/dotfiles"
OS="$OSTYPE"

# Load helpers
. "$DOTFILES_PATH/etc/helpers"

# Check for existence ruby
function check_for_ruby() {
  if command_not_exists ruby curl > /dev/null 2>&1; then
    fail "  x [Error] Ruby and cURL are not installed"; exit 1
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

  if type brew > /dev/null 2>&1; then
    message "  + Homebrew found"
  else
    message "  + Installing Homebrew..."

    if ruby -e "$(curl -fsSL "$installation_url")"; then
      message "  + Homebrew was successfully installed"
    else
      fail "  x [Error] Homebrew was unsuccessfully installed", exit 1
    fi
  fi
}

# Update Homebrew formulas
function update_formulas() {
  ask "  + Do you want to update Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = "Y" ]; then
    message "  + Updating Homebrew"
    if brew update > /dev/null 2>&1; then
      message "  + Done Updating Homebrew"
    else
      fail "  x [Error] Homebrew was unsuccessfully updated", exit 1
    fi
  fi
}

# Upgrade formulas
function upgrade_homebrew() {
  ask "  + Do you want to upgrade Homebrew? [Y/n]:" && read -r flag

  if [ "$flag" = "y" ] || [ "$flag" = 'Y' ]; then
    message "  + Upgrading Homebrew formulas"
    if brew upgrade > /dev/null 2>&1; then
      message "  + Homebrew formulas was successfully upgraded"
    else
      warn "  x [Warning] Homebrew was unsuccessfully upgraded"
    fi
  fi
}

# Tap repositories
function tap_repositories() {
  message "  + Tapping repositories..."

  for repository in $(cat "$DOTFILES_PATH/data/Homebrew/repositories.txt"); do
    brew tap "$repository" > /dev/null 2>&1 || true
    message "  + Done Tapping $repository"
  done
}

# Install formulas
function install_formulas() {
  message "  + Installing formulas..."

  for formula in $(cat "$DOTFILES_PATH/data/Homebrew/formulas.txt"); do
    if brew install "$formula" > /dev/null 2>&1; then
      succeed "  + $formula was successfully installed"
    else
      warn "  x [Warning] $formula was unsuccessfully installed"
    fi
  done
}

# Install Applications to /Applications
function install_osx_applications() {
  message "  + Installing OS X Application..."

  for application in $(cat "$DOTFILES_PATH/data/Homebrew/applications.txt"); do

    if brew cask install $application > /dev/null 2>&1; then
      succeed "  + $application was successfully installed"
    else
      fail "  x [Error] $application unsuccessfully Installed homebrew-cask"; return 1
    fi
  done
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

  is_darwin && install_osx_applications

  remove_caches
}

main
