#!/usr/bin/env zsh
#
# bootstrap
#
# Get ready to develop something
#

declare DOTFILES_PATH
declare NEEDED_PACKAGES

DOTFILES_PATH="$HOME/dotfiles"
NEEDED_PACKAGES="ruby git curl"

function install_dotfiles(){
  if [ -d "$DOTFILES_PATH" ]; then
    cd "$DOTFILES_PATH" && . ./etc/helpers || exit 1
    message "  + Dotfiles is Already exists. Let's go next step"
  else
    if type git &> /dev/null; then
      git clone https://github.com/sachin21/dotfiles.git "$DOTFILES_PATH"
    else
      echo "Git is required. Please install the git."; exit 1
    fi

    cd "$DOTFILES_PATH" && . ./etc/helpers || exit 1
  fi
}

# Initialize other packages
function initialize_submodules(){
  message "  + Initializing git packages"
  git submodule update --init
}

function install_packages(){
  # Checking os
  ask "  + OSX user 'm' : CentOS user 'c' : ArchLinux user 'a' : Ubuntu user 'u' [m/c/a/u]" && read -r flag

  # Setup tools
  if [ "$flag:l" = "m" ]; then # For OS X
    cd "$DOTFILES_PATH" || exit 1
    message "  + Installing Homebrew..."
    ./script/brew.zsh
  elif [ "$flag:l" = "c" ]; then # For CentOS
    message "  + Updating already exists packages..."
    sudo yum -y update || true

    message "  + Upgrading packages..."
    sudo yum -y upgrade || true

    message "  + Installing needed packages..."
    sudo yum -y install $NEEDED_PACKAGES || true

    message "  + Cleaning packages..."
    sudo yum -y clean
  elif [ "$flag:l" = "a" ]; then # For ArchLinux
    message "  + Upgrading packages..."
    sudo pacman -Sy || true

    message "  + Installing needed packages..."
    sudo pacman -S $NEEDED_PACKAGES
  elif [ "$flag:l" = 'u' ]; then
    message " + Updating packages..."
    sudo apt-get update || true

    message " + Upgrading packages..."
    sudo apt-get upgrade || true

    message "  + Installing needed packages..."
    sudo apt-get install -y $NEEDED_PACKAGES || true
  else
    fail "  x [Error] You can input is only 'm', 'c' and 'a'"
    exit 1
  fi

  message "  + Tools was successfully installed"
}

function install_linux_brew() {
  ask "  + Do you install Linuxbrew? [y/Y]" && read -r is_install_linuxbrew
  if [ "$is_install_linuxbrew:l" = "y" ]; then
    message "  + Installing Linuxbrew..."
    ./script/brew.zsh
  fi
}

# Install oh-my-zsh
function install_omz(){
  if [ -d "$HOME/.oh-my-zsh" ]; then
    message "  * oh-my-zsh is exists."
  else
    git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
    message "  + oh-my-zsh was successfully installed"
  fi
}

# Install NeoBundle
function install_neobundle(){
  if [ -d "$HOME/.vim/bundle"] && [ -d "$HOME/.vim/bundle/neobundle.vim" ]; then
    message "  + NeoBundle is exist."
  else
    mkdir -p "$HOME/.vim/bundle" && git clone git://github.com/Shougo/neobundle.vim "$HOME/.vim/bundle/neobundle.vim"
    message "  + NeoBundle was successfully installed"
  fi
}

# Install rbenv
function install_rbenv(){
  if [ -d "$HOME/.rbenv" ]; then
    message "  + rbenv is exist."
  else
    git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"

    if [ -d "$HOME/.rbenv/plugins/ruby-build" ]; then
      message "  + ruby-build is exist."
    else
      git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
      "$HOME/.rbenv/plugins/ruby-build/install.sh"
      message "  + ruby-build was successfully installed"
    fi

    message "  + rbenv was successfully installed"
  fi
}

# Install pyenv
function install_pyenv(){
  if [ -d "$HOME/.pyenv" ]; then
    message "  + pyenv is exists"
  else
    git clone git://github.com/yyuu/pyenv.git "$HOME/.pyenv"
    message "  + pyenv was successfully installed"
  fi
}

# Install nodenv
function install_nodenv(){
  if [ -d "$HOME/.nodenv" ]; then
    message "  + nodenv is exists"
  else
    git clone https://github.com/OiNutter/nodenv.git "$HOME/.nodenv"

    if [ -d "$HOME/.nodenv/.nodenv/plugins/node-build" ]; then
      message "  + node-build is exists"
    else
      git clone git://github.com/OiNutter/node-build.git "$HOME/.nodenv/plugins/node-build"
      "$HOME/.nodenv/plugins/node-build/install.sh"
      message "  + node-build was successfully installed"
    fi

    message "  + nodenv was successfully installed"
  fi
}

# Setup repositories
function install_ghq() {
  if command_not_exists curl; then
    exit
  fi

  ask "  + If you want to create projects of sachin21? [y/Y]" && read -r flag

  if [ "$flag:l" = "y" ]; then
    if command_not_exists ghq; then
      message "  + Installing ghq..."
      brew tap motemen/ghq
      brew install ghq
    fi

    message "  + tapping repositories..."
    curl -fsSL https://api.github.com/users/sachin21/repos \
      | ruby -rjson -e 'JSON.parse(STDIN.read).each{ |r| puts r["name"] }' \
        | while read -r repository; do
      ghq get "https://github.com/sachin21/$repository.git"
    done
  fi
}

function install_zplug() {
  git clone https://github.com/b4b4r07/zplug "$HOME/.zplug"
}

function create_symbolic_links(){
  if command_exists rake; then
    message "  + Executing rake tasks..."
    rake clean
    rake deploy
  else
    warn "  x [Warning] rake is not installed"
  fi
}

function create_needed_dirs() {
  mkdir "$HOME/.go"
}

function create_needed_files() {
  : > "$DOTFILES_PATH/zsh.dot/zshrc.local"
}

function print_after_steps(){
  succeed
  succeed "  Your shell was successfully reloaded."
  succeed "  It's all done."
  succeed
  succeed "  ** After setup: You need to change shell **"
  succeed "  Add $(/usr/bin/which zsh) path to /etc/shells, and"
  succeed "  Execute chsh -s $(command which zsh)"
  succeed
}

function main(){
  install_dotfiles
  initialize_submodules

  while ! install_packages; do
    install_packages
  done

  if [[ "${OSTYPE}" == linux* ]]; then
    install_linux_brew
  fi

  install_omz
  install_neobundle
  install_rbenv
  install_pyenv
  install_nodenv
  install_ghq
  install_zplug
  create_symbolic_links
  create_needed_dirs
  create_needed_files

  print_after_steps
}

main
