#!/usr/bin/env bash
#
# bootstrap
#
# Get readly to develop something

declare -r DOTFILES_PATH
DOTFILES_PATH="$HOME/dotfiles"

# Loading method for printing
. "$DOTFILES_PATH/etc/helpers"

if command_not_exists git; then
  fail "  x [Error] git is not installed"
  exit 1
fi

if [ "$(basename "$PWD")" = "dotfiles" ]; then
  message "  + Already exists dotfiles. Let's go next step"
else
  message "  + Cloning into ~/dotfiles..."
  git clone https://github.com/sachin21/dotfiles.git ~/dotfiles
  cd ~/dotfiles || exit 1
fi

# Initialize other packages
message "  + Initializing git packages"
git submodule update --init

# Checking os
ask "  + OSX user 'm' : CentOS user 'c' : ArchLinux user [m/c/a] : " && read -r flag

# Setup tools
if [ "$flag" = "m" ] || [ "$flag" = "M" ]; then # For Mac OSX
  cd ~/dotfiles || exit 1
  message "  + Installing Homebrew..."
  ./script/brew.sh
elif [ "$flag" = "c" ] || [ "$flag" = "C" ]; then # For CentOS
  message "  + Updating already exists packages..."
  sudo yum -y update

  message "  + Upgrading packages..."
  sudo yum -y upgrade

  message "  + Cleaning packages..."
  sudo yum -y clean

  message "  + Installing Linuxbrew..."
  ./script/brew.sh
elif [ "$flag" = "a" ] || [ "$flag" = "A" ]; then # For ArchLinux
  message "  + Upgrading packages..."
  sudo pacman -Sy

  message "  + Installing Linuxbrew..."
  ./script/brew.sh
else
  ask "  x You can input is only 'm', 'c' and 'a'"
  exit 1
fi
message "  + Tools was successfully installed"

# Install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
  message "  * oh-my-zsh is exists."
else
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  message "  + oh-my-zsh was successfully installed"
fi

# Install NeoBundle
if [ -d ~/.vim/bundle ] && [ -d ~/.vim/bundle/neobundle.vim ]; then
  message "  + NeoBundle is exist."
else
  mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  message "  + NeoBundle was successfully installed"
fi

# Install rbenv
if [ -d ~/.rbenv ]; then
  message "  + rbenv is exist."
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  if [ -d ~/.rbenv/plugins/ruby-build ]; then
    message "  + ruby-build is exist."
  else
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    ~/.rbenv/plugins/ruby-build/install.sh
    message "  + ruby-build was successfully installed"
  fi

  message "  + rbenv was successfully installed"
fi

# Install pyenv
if [ -d ~/.pyenv ]; then
  message "  + pyenv is exists"
else
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  message "  + pyenv was successfully installed"
fi

# Install nodenv
if [ -d ~/.nodenv ]; then
  message "  + nodenv is exists"
else
  git clone https://github.com/OiNutter/nodenv.git ~/.nodenv

  if [ -d ~/.nodenv/.nodenv/plugins/node-build ]; then
    message "  + node-build is exists"
  else
    git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build
    ~/.nodenv/plugins/node-build/install.sh
    message "  + node-build was successfully installed"
  fi

  message "  + nodenv was successfully installed"
fi

ask "  + If you want to create projects of sachin21? [y/Y]" && read -r flag

# Setup repositories
if [ "$flag" = "y" ] || [ "$flag" = "Y" ]; then
  install_ghq() {
    cat < repositories/github | while read -r repository; do
      ghq get "$repository"
    done
  }

  if command_exists ghq; then
    install_ghq
  else
    message "  + Installing ghq..."
    brew tap motemen/ghq
    brew install ghq

    install_ghq
  fi
fi

# Create symbolics
if command_exists rake; then
  message "  + Executing rake tasks..."
  rake clean
  rake all
else
  warn "  x [Warning] rake is not installed"
fi

succeed "  + Your shell was reloaded."
succeed "  + It's all done."
succeed ""
succeed "  ** After setup: You need to change shell **"
succeed "  Add $(/usr/bin/which zsh) path to /etc/shells, and"
succeed "  Execute 'chsh -s $(/usr/bin/which zsh)'"
succeed ""

exit 0
