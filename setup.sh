#!/usr/bin/env sh

# init other package
git submodule init
git submodule update

# check os
echo "MacOS user 'm' : Centos user 'c' : ArchLinux user [m/c/a] : "
  read flag

# setup tools
if [ $flag = 'm' -o $flag = 'M' ]; then # for Mac OSX
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  cd ~/dotfiles
  brew bundle
  cp zsh.dot/zshrc.local.sample zsh.dot/zshrc.local
elif [ $flag = 'c' -o $flag = 'C' ]; then # for CentOS
  sudo yum -y update
  sudo yum -y upgrade

  for rpm in `cat ./package_repo/rpm`; do
    sudo rpm -ivh $rpm
  done

  for package in `cat ./package_lists/yum`; do
    sudo yum -y install $package
  done

  sudo yum -y clean
elif [ $flag = 'a' -o $flag = 'A' ]; then # for ArchLinux
  sudo pacman -Sy

  for package in `cat ./package_lists/pacman`; do
    sudo pacman -S $package
  done
else
  echo "You can input is only 'm', 'c' and 'a'"
  exit 1
fi
echo "tools success install"

# set links
DOT_FILES=( .zsh .zshrc zsh .gemrc .vimrc .gitconfig .bundle .tmux.conf .dir_colors .pryrc tmux )

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


function install_sachin21_projects() {
  mkdir -p ~/DevelopersApp/sachin21/rails_apps
  mkdir -p ~/DevelopersApp/sachin21/utilities/gems
  mkdir -p ~/DevelopersApp/sachin21/sachin21.info

  cd ~/DevelopersApp/sachin21

  git clone https://github.com/sachin21/jd-rank ./rails_apps/jd-rank
  git clone https://github.com/sachin21/enterrrrrr ./rails_apps/enterrrrrr
  git clone https://github.com/sachin21/space2underscore ./utilities/gems/space2underscore
  git clone https://github.com/sachin21/space2dot ./utilities/gems/space2dot
  git clone https://github.com/sachin21/profile.sachin21.info ./sachin21.info/profile.sachin21.info
  git clone https://github.com/sachin21/diary.sachin21.info ./sachin21.info/diary.sachin21.info
}

echo "If you want to create sachin21 of projects"
  read flag

# setup repositories
if [ $flag = 'y' -o $flag = 'Y' ]; then
  install_sachin21_projects
fi

# reload shell
exec $SHELL

echo "your shell reloaded"
echo "all success install"
echo '
** you need to change shell **
ex: chsh -s /usr/local/bin/zsh'
