#!/usr/bin/env zsh

# check os
echo -n "MacOS user 'm' : Centos user 'c' : ArchLinux user [m/c/a] : "
  read flag

# setup tools
if [ $flag = 'm' -o $flag = 'M' ]; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  cd ~/dotfiles
  brew bundle
elif [ $flag = 'c' -o $flag = 'C' ]; then
  sudo yum -y update
  sudo yum -y upgrade
  for package in `cat ./package_lists/yum`; do; yum -y install $package; done
  sudo yum -y clean
elif [ $flag = 'a' -o $flag = 'A' ]; then
  sudo pacman -Sy
  for package in `cat ./package_lists/pacman`; do; sudo pacman -S $package; done
else
  echo "You can input is only 'm', 'c' and 'a'"
  exit 1
fi
echo "tools success install"

# set links
DOT_FILES=( .zsh .zshrc .gemrc .vimrc .gitconfig .bundle .tmux.conf .dir_colors .pryrc tmux )

for file in ${DOT_FILES[@]}; do
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
[ ! -d ~/.rbenv ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
[ ! -d ~/.rbenv/plugins/ruby-build ] && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
echo "rbenv success install"

# install pyenv
[ ! -d ~/.pyenv ] && git clone git://github.com/yyuu/pyenv.git ~/.pyenv
echo "pyenv success install"

# install nodenv
[ ! -d ~/.nodenv ] && git clone https://github.com/OiNutter/nodenv.git ~/.nodenv
[ ! -d ~/.nodenv/.nodenv/plugins/node-build ] && git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build
~/.nodenv/plugins/node-build/install.sh
echo "nodenv success install"

# install tmuxinator
cp -r .tmuxinator ~/
echo "tmuxinator success install"

# reload shell
exec $SHELL

echo "your shell reloaded"
echo "all success install"

