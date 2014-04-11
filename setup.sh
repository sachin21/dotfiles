#!/bin/bash

# check os
echo -n "Mac user 'm' : Centos user 'c' [m/c] : "
  read flag

# setup tools
if [ $flag = 'm' -o $flag = 'm' ]
  then
  # ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew upgrade
  brew install zsh git tig redis readline mysql sqlite coreutils openssl tmux node fish phantomjs curl wget imagemagick fontforge the_silver_searcher libevent libpng ricty libtool
elif [ $flag = 'c' -o $flag = 'c' ]
  then
  sudo yum -y update
  sudo yum -y upgrade
  sudo yum -y install zsh git wget php gcc zlib-devel openssl-devel mysql-server
  sudo yum -y clean
else
  echo "failed"
  exit 1
fi
echo "tools setup done"

# set links
DOT_FILES=( .zsh .zshrc .gemrc .vimrc .gitconfig .tmux.conf .dir_colors .pryrc )

for file in ${DOT_FILES[@]}
  do
    ln -fs $HOME/dotfiles/$file $HOME/$file
  done
echo "set links done"

# reload shell
source ~/.zshrc
echo "reloaded"

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim && vim -c ':NeoBundleInstall'
echo "success install"

# install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo "setup rbenv done"
echo "all success install"

