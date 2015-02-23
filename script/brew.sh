#!/usr/bin/env sh

set -e

if ! type brew > /dev/null 2>&1; then
  echo "  + Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "  + Homebrew was successfully installed"
else
  echo "  x Homebrew not found"
  exit 1
fi

# Update Homebrew formulas
echo "  + Do you update Homebrew? [Y/n]:" && read flag

if [ $flag = 'y' -o $flag = 'Y' ]; then
  echo "  + Updating Homebrew"
  brew update
fi

# Upgrade formulas
echo "  + Do you upgrade Homebrew? [Y/n]:" && read flag

if [ $flag = 'y' -o $flag = 'Y' ]; then
  echo "  + Upgrading Homebrew formulas"
  brew upgrade
fi

## For homebrew/versions
brew tap homebrew/versions

## For peco
brew tap peco/peco

## For ghq
brew tap motemen/ghq

## For gitsh
brew tap thoughtbot/formulae

## For zlib
brew tap homebrew/dupes

## For binary formulas
brew tap homebrew/binary

formulas=(
  # Shells
  bash
  fish
  ksh
  zsh

  # Search tools
  ack
  the_platinum_searcher
  the_silver_searcher

  # Build tools
  autoconf
  automake
  cmake
  gcc
  gcc46
  gcc47
  gcc48

  # Languages
  go
  perl
  python
  python3
  ruby20
  scala

  # Git
  gibo
  gist
  git
  gitsh
  tig
  hub

  # Utilities
  autojump
  cmatrix
  coreutils
  csvprintf
  ghq
  jenkins
  peco
  rmtrash
  sl
  stress
  terminal-notifier
  tree

  # For Fonts
  fontconfig
  fontforge

  # Editors
  emacs
  vim

  # Libraries
  elasticsearch
  elasticsearch11
  ffmpeg
  gettext
  glib
  imagemagick
  jpeg
  libevent
  libffi
  libmpc
  libmpc08
  libpng
  libtiff
  libtool
  libvo-aacenc
  libxml2
  libxslt
  libyaml
  mpfr
  mpfr2
  mpg123
  ncurses
  openssl
  qt
  readline
  v8
  x264
  xvid
  xz
  zlib

  # JavaScript Formulas
  node
  phantomjs

  # Databases
  mongodb
  mysql
  postgresql
  sqlite

  # Servers
  memcached
  reattach-to-user-namespace
  redis
  tmux

  # Dependency Formulas
  bdw-gc
  binutils
  bison
  cairo
  cloog
  cloog-ppl015
  cloog018
  crunch
  faac
  freetype
  gdbm
  gmp
  gmp4
  gobject-introspection
  harfbuzz
  icu4c
  isl
  isl011
  lame
  mercurial
  ossp-uuid
  pango
  pcre
  pixman
  pkg-config
  ppl011
  unixodbc
  czmq
  libsodium
  zeromq

  # Crawlers
  curl
  w3m
  wget
  youtube-dl
)

echo "Installing formulas..."
brew install ${formulas[@]} && brew cleanup

# Install Homebrew-cask
brew install caskroom/cask/brew-cask

# For OSX
apps=(
  alfred
  clipmenu
  dash
  evernote
  firefox
  flux
  google-chrome
  google-japanese-ime
  heroku-toolbelt
  hipchat
  iexplorer
  istat-menus
  iterm2
  java
  karabiner
  kobito
  mou
  opera
  parallels
  pg-commander
  picasa
  screenhero
  sequel-pro
  skitch
  skype
  slack
  sparrow
  sublime-text
  teitoku
  the-unarchiver
  transmit
  utorrent
  vagrant
  virtualbox
  vlc
  xld
  xtrafinder
  yorufukurou
)

# Install apps to /Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# For alfred
brew cask alfred link

# Remove outdated versions and archive file
brew cleanup
brew cask cleanup
