require 'rake/clean'

HOME = ENV['HOME']

ZSH_ROOT      = File.join(File.dirname(__FILE__), 'zsh')
ZSH_DOT_ROOT  = File.join(File.dirname(__FILE__), 'zsh.dot')
ZSH_DOT_FILES = `ls zsh.dot`.split("\n").freeze

VIM_ROOT      = File.join(File.dirname(__FILE__), 'vim')
VIM_DOT_ROOT  = File.join(File.dirname(__FILE__), 'vim.dot')
VIM_DOT_FILES = `ls vim.dot`.split("\n").freeze

TMUX_ROOT     = File.join(File.dirname(__FILE__), 'tmux')
TMUX_DOT_ROOT = File.join(File.dirname(__FILE__), 'tmux.dot')
TMUX_FILES = `ls tmux.dot`.split("\n").freeze

GIT_ROOT      = File.join(File.dirname(__FILE__), 'git')
GIT_FILES = `ls git`.split("\n").freeze

ETC_ROOT      = File.join(File.dirname(__FILE__), 'etc')
ETC_FILES = `ls etc`.split("\n").freeze

CLEANS = %w(
  .zsh
  .zshrc
  .zshrc.alias
  .zshrc.config
  .zshrc.env
  .zshrc.function
  .zshrc.linux
  .zshrc.local
  .zshrc.osx
  .zshrc.setting
  .tmux
  .tmuxinator
  .tmux.conf
  .vim
  .vimrc
  .vimrc.apperance
  .vimrc.basic
  .vimrc.bundle
  .vimrc.colors
  .vimrc.completion
  .vimrc.completion.autocomplpop
  .vimrc.completion.neocomplcache
  .vimrc.editing
  .vimrc.encoding
  .vimrc.indent
  .vimrc.misc
  .vimrc.moving
  .vimrc.plugins_setting
  .vimrc.search
  .vimrc.statusline
  .gitconfig
  .global_ignore
  .gemrc
  .peco
  .pryrc
  .bundle
  .dircolors
  .tigrc
  .railsrc
  .agignore
  .helpers
).freeze

CLEAN.concat(CLEANS.map { |c| File.join(HOME, c) })

task default: :deploy

desc 'Create symbolic links for the all dotfiles'
task deploy: %w(zsh:link vim:link git:link tmux:link etc:link)

namespace :zsh do
  desc 'Create symbolic links for zsh settings file to HOME'
  task :link do
    _symlink File.join(ZSH_DOT_ROOT, 'zshrc'), File.join(HOME, '.zshrc')
    _symlink File.join(ZSH_ROOT), File.join(HOME, '.zsh')
    same_name_symlinks ZSH_DOT_ROOT, ZSH_DOT_FILES
  end
end

namespace :vim do
  desc 'Create symbolic links for vimrc to HOME'
  task :link do
    _symlink File.join(VIM_ROOT), File.join(HOME, '.vim')
    _symlink File.join(VIM_DOT_ROOT, 'vimrc'), File.join(HOME, '.vimrc')
    same_name_symlinks VIM_DOT_ROOT, VIM_DOT_FILES
  end
end

namespace :git do
  desc 'Create symbolic links for git files to HOME'
  task :link do
    same_name_symlinks GIT_ROOT, GIT_FILES
  end
end

namespace :tmux do
  desc 'Create symbolic links for tmux config files to HOME'
  task :link do
    _symlink File.join(TMUX_ROOT), File.join(HOME, '.tmux')
    same_name_symlinks TMUX_DOT_ROOT, TMUX_FILES
  end
end

namespace :etc do
  desc 'Create symbolic links  for etcs link to HOME'
  task :link do
    same_name_symlinks ETC_ROOT, ETC_FILES
  end
end

desc 'Update all git repositories'
task :update do
  sh 'git pull origin master'
  sh 'git submodule foreach git pull origin master'
  sh './bin/update_install_tools'
  sh 'env ZSH=$ZSH /bin/sh /Users/sachin21dev/.oh-my-zsh/tools/upgrade.sh'
end

def _symlink(file, dest)
  symlink file, dest unless File.exist?(dest)
end

def same_name_symlinks(root, files)
  files.each do |file|
    _symlink File.join(root, file), File.join(HOME, '.' + file)
  end
end
