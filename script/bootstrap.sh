#!/usr/bin/env sh
#
# bootstrap
#
# Get readly to develop something

set -e

if [ ! $(basename `pwd`) = "dotfiles" ]; then
  echo "  + Cloning into ~/dotfiles..."
  git clone git@github.com:sachin21/dotfiles.git ~/dotfiles
  cd ~/dotfiles
else
  echo "  + Already exist dotfiles. Let's go next step"
fi

# Initialize other packages
echo "  + Initializing git submodule"
git submodule update --init

# Check os
echo "  + OSX user 'm' : CentOS user 'c' : ArchLinux user [m/c/a] : "
  read flag

# Setup tools
if [ $flag = 'm' -o $flag = 'M' ]; then # For Mac OSX
  cd ~/dotfiles
  echo "  + Installing Homebrew..."
  ./Homebrew/install.sh
elif [ $flag = 'c' -o $flag = 'C' ]; then # For CentOS
  echo "  + Updating already exist packages..."
  sudo yum -y update

  echo "  + Upgrading packages..."
  sudo yum -y upgrade

  for rpm in `cat ./package_repo/rpm`; do
    echo "  + Installing rpm..."
    sudo rpm -ivh $rpm
  done

  for package in `cat ./package_lists/yum`; do
    echo "  + Installing packages..."
    sudo yum -y install $package
  done

  echo "  + Cleaning packages..."
  sudo yum -y clean

  echo "  + Installing Linuxbrew..."
  ./Homebrew/install.linux.sh
elif [ $flag = 'a' -o $flag = 'A' ]; then # For ArchLinux
  echo "  + Upgrading packages..."
  sudo pacman -Sy

  for package in `cat ./package_lists/pacman`; do
    echo "  + Installing packages..."
    sudo pacman -S $package
  done
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
  mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim && vim -c ':NeoBundleInstall'
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
if [ $flag = 'y' -o $flag = 'Y' ] && type ghq > /dev/null 2>&1; then
  for repository in `cat repositories/github`; do
    ghq get $repository
  done
else
  echo "  x [Warning] ghq is not installed" 1>&2
fi

# Create symbolics
if type rake > /dev/null 2>&1; then
  echo "  + Executing rake tasks..."
  rake clean
  rake all
else
  echo "  x [Warning] rake is not installed" 1>&2
fi

# Reload shell
exec $SHELL

echo "  + Your shell was reloaded."
echo "  + It's all done."
echo "
** After setup: You need to change shell **
Add $(/usr/bin/which zsh) path to /etc/shells, and
Execute 'chsh -s $(/usr/bin/which zsh)'"
