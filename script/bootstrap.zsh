#!/usr/bin/env zsh
#
# bootstrap
#
# Get ready to develop something
#

declare DOTFILES_PATH="$HOME/dotfiles"
declare NEEDED_PACKAGES=(ruby git curl)

function install_dotfiles(){
  if [ -d "$DOTFILES_PATH" ]; then
    . "$DOTFILES_PATH"/etc/helpers
    message "  + Dotfiles is Already exists. Let's go next step"
  else
    if type git > /dev/null 2>&1; then
      git clone https://github.com/sachin21/dotfiles.git "$DOTFILES_PATH" > /dev/null 2>&1
      . "$DOTFILES_PATH"/etc/helpers

      succeed "  + Dotfiles was successfully downloaded"
    else
      echo "  x [Error] Git is required. Please install the git."; exit 1
    fi
  fi
}

function cd_dotfiles() {
  cd $DOTFILES_PATH
}

# Initialize other packages
function initialize_submodules(){
  message "  + Initializing git submodules"

  if git submodule update --init > /dev/null 2>&1; then
    succeed "  + Submodule successfully Initialized"
  else
    fail "  x [Error] Submodules unsuccessfully Initialized"; exit 1
  fi
}

function install_packages(){
  # Setup tools
  if [ "$(uname)" = 'Darwin' ]; then
    if ! ./script/brew.zsh; then
      fail "  x [Error] Homebrew was unsuccessfully installed", exit 1
    fi
  else
    # Checking os
    ask "  + CentOS user 'c' : ArchLinux user 'a' : Ubuntu user 'u' [c/a/u]" && read -r flag
    if [ "$flag:l" = "c" ]; then # For CentOS
      message "  + Updating already exists packages..."
      sudo yum -y update > /dev/null 2>&1 || true

      message "  + Upgrading packages..."
      sudo yum -y upgrade > /dev/null 2>&1 || true

      message "  + Installing needed packages..."
      sudo yum -y install $NEEDED_PACKAGES > /dev/null 2>&1 || true

      message "  + Cleaning packages..."
      sudo yum -y clean > /dev/null 2>&1
    elif [ "$flag:l" = "a" ]; then # For ArchLinux
      message "  + Upgrading packages..."
      sudo pacman -Sy > /dev/null 2>&1 || true

      message "  + Installing needed packages..."
      sudo pacman -S $NEEDED_PACKAGES
    elif [ "$flag:l" = 'u' ]; then
      message " + Updating packages..."; sleep 3
      sudo apt-get -y update

      message " + Upgrading packages..."; sleep 3
      sudo apt-get -y upgrade

      message "  + Installing needed packages..."; sleep 3
      sudo apt-get -y install $NEEDED_PACKAGES
    else
      fail "  x [Error] You can input is only 'm', 'c' and 'a'"; exit 1
    fi
  fi

  succeed "  + Tools was successfully installed"
}

function install_linux_brew() {
  ask "  + Do you install Linuxbrew? [y/Y]" && read -r is_install_linuxbrew
  if [ "$is_install_linuxbrew:l" = "y" ]; then
    message "  + Installing Linuxbrew..."
    ./script/brew.zsh
  fi
}

# Install oh-my-zsh
function install_omz(){
  if [ -d "$HOME/.oh-my-zsh" ]; then
    message "  * oh-my-zsh is exists."
  else
    if git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" > /dev/null 2>&1; then
      succeed "  + oh-my-zsh was successfully installed"
    else
      fail "  x [Error] oh-my-zsh was unsuccessfully installed", exit 1
    fi
  fi
}

# Install rbenv
function install_rbenv(){
  if [ -d "$HOME/.rbenv" ]; then
    message "  + rbenv is exist."
  else
    if git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv" > /dev/null 2>&1; then
      succeed "  + rbenv was successfully installed"
    else
      fail "  x [Error] rbenv was unsuccessfully installed", exit 1
    fi

    if [ -d "$HOME/.rbenv/plugins/ruby-build" ]; then
      message "  + ruby-build is exist."
    else
      if git clone https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build" > /dev/null 2>&1 && sudo "$HOME/.rbenv/plugins/ruby-build/install.sh" > /dev/null 2>&1; then
        succeed "  + ruby-build was successfully installed"
      else
        fail "  x [Error] ruby-build was unsuccessfully installed", exit 1
      fi
    fi
  fi
}

# Install pyenv
function install_pyenv(){
  if [ -d "$HOME/.pyenv" ]; then
    message "  + pyenv is exists"
  else
    if git clone git://github.com/yyuu/pyenv.git "$HOME/.pyenv" > /dev/null 2>&1; then
      succeed "  + pyenv was successfully installed"
    else
      fail "  x [Error] pyenv was unsuccessfully installed", exit 1
    fi
  fi
}

# Install nodenv
function install_nodenv(){
  if [ -d "$HOME/.nodenv" ]; then
    message "  + nodenv is exists"
  else
    if git clone https://github.com/OiNutter/nodenv.git "$HOME/.nodenv" > /dev/null 2>&1; then
      succeed "  + nodenv was successfully installed"
    else
      fail "  x [Error] nodenv was unsuccessfully installed", exit 1
    fi

    if [ -d "$HOME/.nodenv/.nodenv/plugins/node-build" ]; then
      message "  + node-build is exists"
    else
      if git clone git://github.com/OiNutter/node-build.git "$HOME/.nodenv/plugins/node-build" > /dev/null 2>&1 && sudo "$HOME/.nodenv/plugins/node-build/install.sh" > /dev/null 2>&1; then
        succeed "  + node-build was successfully installed"
      else
        fail "  x [Error] nodenv was unsuccessfully installed", exit 1
      fi
    fi
  fi
}

# Setup repositories
function install_ghq() {
  if command_not_exists curl > /dev/null 2>&1; then
    fail "  x [Error] cURL is not installed"; return 1
  fi

  ask "  + If you want to create projects of sachin21? [y/Y]" && read -r flag

  if [ "$flag:l" = "y" ]; then
    if command_exists ghq > /dev/null 2>&1; then
      message "  + Installing ghq..."
      if brew tap motemen/ghq > /dev/null 2>&1 && brew install ghq > /dev/null 2>&1; then
        succeed "  + ghq was successfully installed"
      fi
    fi

    message "  + tapping repositories..."
    curl -fsSL https://api.github.com/users/sachin21/repos \
      | ruby -rjson -e 'JSON.parse(STDIN.read).each{ |r| puts r["name"] }' \
        | while read -r repository; do
      message "  + Cloning $repository..."
      ghq get "https://github.com/sachin21/$repository.git" || true
    done
  fi
}

function install_zplug() {
  git clone https://github.com/b4b4r07/zplug "$HOME/.zplug" > /dev/null 2>&1
}

function install_mikutter_plugins() {
  local mikutter_home="$HOME/.mikutter/plugin"

  rm -fr "$mikutter_home"
  rm -fr "$mikutter_home/display_requirements.rb"

  mkdir -p $mikutter_home
  : > "$mikutter_home/display_requirements.rb"

  message '  + Installing mikutter plugins'
  for repository in $(cat data/mikutter_plugins.txt); do
    git clone $repository "$HOME/.mikutter/plugin/$(basename "$repository" | sed -e 's/-/_/g')" > /dev/null 2>&1
  done

  succeed '  + mikutter plugins ware successfully installed'
}

function create_symbolic_links(){
  if command_not_existsrake > /dev/null 2>&1; then
    warn "  x [Warning] rake is not installed"; return 1
  fi

  message "  + Executing rake tasks..."
  rake clean > /dev/null 2>&1
  if ! rake deploy > /dev/null 2>&1; then
    fail '  x Dotfiles was unsuccessfully deployed'; return 1
  fi
}

function create_needed_dirs() {
  if ! [ -d "$HOME/.go" ]; then
    mkdir "$HOME/.go"
  fi
}

function create_needed_files() {
  : > "$DOTFILES_PATH/zsh.dot/zshrc.local"
}

function change_default_shell() {
  message '  + Changing default shell...'

  if [ -d /usr/local/bin/zsh ]; then
    sudo echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s /usr/local/bin
  else
    chsh -s /bin/zsh
  fi
}

function change_shell_to_zsh() {
  /bin/zsh
}

function main(){
  install_dotfiles
  cd_dotfiles
  initialize_submodules

  while ! install_packages; do
    install_packages
  done

  if [[ "${OSTYPE}" == linux* ]]; then
    install_linux_brew
  fi

  install_omz
  install_rbenv
  install_pyenv
  install_nodenv
  install_ghq
  install_zplug
  install_mikutter_plugins
  create_symbolic_links
  create_needed_dirs
  create_needed_files
  change_default_shell
  change_shell_to_zsh
}

main
