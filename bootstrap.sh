#!/usr/bin/env sh

# init other packages
git submodule init
git submodule update

# check os
echo "MacOS user 'm' : Centos user 'c' : ArchLinux user [m/c/a] : "
  read flag

# setup tools
if [ $flag = 'm' -o $flag = 'M' ]; then # For Mac OSX
  cd ~/dotfiles
  ./Homebrew/install.sh
elif [ $flag = 'c' -o $flag = 'C' ]; then # For CentOS
  sudo yum -y update
  sudo yum -y upgrade

  for rpm in `cat ./package_repo/rpm`; do
    sudo rpm -ivh $rpm
  done

  for package in `cat ./package_lists/yum`; do
    sudo yum -y install $package
  done

  sudo yum -y clean
  ./Homebrew/install.linux.sh
elif [ $flag = 'a' -o $flag = 'A' ]; then # For ArchLinux
  sudo pacman -Sy

  for package in `cat ./package_lists/pacman`; do
    sudo pacman -S $package
  done
else
  echo "You can input is only 'm', 'c' and 'a'"
  exit 1
  ./Homebrew/install.linux.sh
fi
echo "Tools was successfully installed."

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "oh-my-zsh was successfully installed."

# install NeoBundle
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim && vim -c ':NeoBundleInstall'
echo "NeoBundle was successfully installed."

# install rbenv
[ ! -d ~/.rbenv ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
[ ! -d ~/.rbenv/plugins/ruby-build ] && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
~/.rbenv/plugins/ruby-build/install.sh
echo "rbenv was successfully installed."

# install pyenv
[ ! -d ~/.pyenv ] && git clone git://github.com/yyuu/pyenv.git ~/.pyenv
echo "pyenv was successfully installed."

# install nodenv
[ ! -d ~/.nodenv ] && git clone https://github.com/OiNutter/nodenv.git ~/.nodenv
[ ! -d ~/.nodenv/.nodenv/plugins/node-build ] && git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build
~/.nodenv/plugins/node-build/install.sh
echo "nodenv was successfully installed."

echo "If you want to create projects of sachin21? [y/Y]"
  read flag

# setup repositories
if [ $flag = 'y' -o $flag = 'Y' ] && type ghq > /dev/null 2>&1; then
  for repository in `cat repositories/github`; do
    ghq get $repository
  done
else
  echo "[Warning] ghq is not installed" 1>&2
fi

# create symbolics
rake clean
rake all

# reload shell
exec $SHELL

echo "Your shell was reloaded"
echo "All done."
echo "
** After setup: You need to change shell **
Add $(/usr/bin/which zsh) path to /etc/shells, and
Execute 'chsh -s $(/usr/bin/which zsh)'"
