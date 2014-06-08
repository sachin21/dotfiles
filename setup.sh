#!/bin/bash

# check os
echo -n "MacOS user 'm' : Centos user 'c' [m/c] : "
  read flag

# setup tools
if [ $flag = 'm' -o $flag = 'm' ]
  then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew bundle
elif [ $flag = 'c' -o $flag = 'c' ]
  then
  sudo yum -y update
  sudo yum -y upgrade
  sudo yum -y install zsh git vim wget php gcc zlib-devel libyaml readline readline-devel  libxml2 libxml2-devel libxslt libxslt-devel libyaml-devel make gcc-c++ utomake pcre pcre-devel openssl openssl-devel mysql-server
  sudo yum -y clean
else
  echo "You can input is only 'm' or 'c'"
  exit 1
fi
echo "tools success install"

# set links
DOT_FILES=( .zsh .zshrc .gemrc .vimrc .gitconfig .tmux.conf .dir_colors .pryrc tmux )

for file in ${DOT_FILES[@]}
  do
    ln -fs ~/dotfiles/$file ~/$file
  done
echo "set links done"

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "oh-my-zsh success install"

# install NeoBundle
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim && vim -c ':NeoBundleInstall'
echo "NeoBundle success install"

# install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo "rbenv d success install"

# install tmuxinator
cp -r .tmuxinator ~/
echo "tmuxinator success install"

# reload shell
exec $SHELL
echo "Your shell reloaded"

echo "all success install"

