#!/usr/bin/env sh
#
# bootstrap
#
# Get readly to develop something

set -e

if ! type git > /dev/null 2>&1; then
  echo "  x [Error] git is not installed"
  exit 1
fi

if [ $(basename `pwd`) = "dotfiles" ]; then
  echo "  + Already exist dotfiles. Let's go next step"
else
  echo "  + Cloning into ~/dotfiles..."
  git clone https://github.com/sachin21/dotfiles.git ~/dotfiles
  cd ~/dotfiles
fi

# Initialize other packages
echo "  + Initializing git submodules"
git submodule update --init

# Checking os
echo "  + OSX user 'm' : CentOS user 'c' : ArchLinux user [m/c/a] : "
  read flag

# Setup tools
if [ $flag = 'm' -o $flag = 'M' ]; then # For Mac OSX
  cd ~/dotfiles
  echo "  + Installing Homebrew..."
  ./script/brew.sh
elif [ $flag = 'c' -o $flag = 'C' ]; then # For CentOS
  echo "  + Updating already exist packages..."
  sudo yum -y update

  echo "  + Upgrading packages..."
  sudo yum -y upgrade

  echo "  + Cleaning packages..."
  sudo yum -y clean

  echo "  + Installing Linuxbrew..."
  ./script/brew.linux.sh
elif [ $flag = 'a' -o $flag = 'A' ]; then # For ArchLinux
  echo "  + Upgrading packages..."
  sudo pacman -Sy

  echo "  + Installing Linuxbrew..."
  ./script/brew.linux.sh
else
  echo "  x You can input is only 'm', 'c' and 'a'"
  exit 1
fi
echo "  + Tools was successfully installed"

# Install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
  echo "  + oh-my-zsh is exist."
else
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  echo "  + oh-my-zsh was successfully installed"
fi

# Install NeoBundle
if [ -d ~/.vim/bundle -a -d ~/.vim/bundle/neobundle.vim ]; then
  echo "  + NeoBundle is exist."
else
  mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  echo "  + NeoBundle was successfully installed"
fi

# Install rbenv
if [ -d ~/.rbenv ]; then
  echo "  + rbenv is exist."
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  if [ -d ~/.rbenv/plugins/ruby-build ]; then
    echo "  + ruby-build is exist."
  else
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    ~/.rbenv/plugins/ruby-build/install.sh
    echo "  + ruby-build was successfully installed"
  fi

  echo "  + rbenv was successfully installed"
fi

# Install pyenv
if [ -d ~/.pyenv ]; then
  echo "  + pyenv is exist"
else
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  echo "  + pyenv was successfully installed"
fi

# Install nodenv
if [ -d ~/.nodenv ]; then
  echo "  + nodenv is exist"
else
  git clone https://github.com/OiNutter/nodenv.git ~/.nodenv

  if [ -d ~/.nodenv/.nodenv/plugins/node-build ]; then
    echo "  + node-build is exist"
  else
    git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build
    ~/.nodenv/plugins/node-build/install.sh
    echo "  + node-build was successfully installed"
  fi

  echo "  + nodenv was successfully installed"
fi

echo "  + If you want to create projects of sachin21? [y/Y]"
  read flag

# Setup repositories
if [ $flag = 'y' -o $flag = 'Y' ]; then
  install_ghq() {
    for repository in `cat repositories/github`; do
      ghq get $repository
    done
  }

  if type ghq > /dev/null 2>&1; then
    install_ghq
  else
    echo "  x [Warning] ghq is not installed"

    if type brew > /dev/null 2>&1; then
      echo "  + Installing ghq..."
      brew tap motemen/ghq
      brew install ghq
    fi
    install_ghq
  fi
fi

# Create symbolics
if type rake > /dev/null 2>&1; then
  echo "  + Executing rake tasks..."
  rake clean
  rake all
else
  echo "  x [Warning] rake is not installed"
fi

# Reload shell
exec $SHELL

echo "  + Your shell was reloaded."
echo "  + It's all done."
echo "
** After setup: You need to change shell **
Add $(/usr/bin/which zsh) path to /etc/shells, and
Execute 'chsh -s $(/usr/bin/which zsh)'"
