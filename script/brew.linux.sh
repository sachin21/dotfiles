#!/usr/bin/env sh

set -e

if type brew > /dev/null 2>&1; then
  echo "  + Homebrew found"
else
  echo "  + Installing linuxbrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  echo "  + Homebrew was successfully installed"
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

echo "Tapping taps..."
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

## For Ricty
brew tap sanemat/font

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
  libgit2
  libgit2-glib
  tig

  # Utilities
  autojump
  cmatrix
  coreutils
  csvprintf
  ghq
  jenkins
  peco
  sl
  stress
  terminal-notifier
  tree
  ccat

  # For Fonts
  fontconfig
  fontforge
  ricty

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
  libssh2
  libtiff
  libtool
  libvo-aacenc
  libxml2
  libxslt
  libyaml
  moreutils
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

  # Tools
  boot2docker
  docker
)

echo "Installing formulas..."
brew install ${formulas[@]} && brew cleanup

# Remove outdated versions and archive file
echo "Cleaning caches..."
brew cleanup
