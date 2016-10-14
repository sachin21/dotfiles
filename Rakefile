require 'rake/clean'

HOME = ENV['HOME']

ZSH_DOT_ROOT  = File.join(File.dirname(__FILE__), 'zsh.dot')
ZSH_DOT_FILES = `ls zsh.dot`.split("\n").freeze

VIM_ROOT      = File.join(File.dirname(__FILE__), 'vim')
VIM_DOT_ROOT      = File.join(File.dirname(__FILE__), 'vim.dot')
VIM_DOT_FILES = `ls vim.dot`.split("\n").freeze

TMUX_ROOT     = File.join(File.dirname(__FILE__), 'tmux')
TMUX_DOT_ROOT = File.join(File.dirname(__FILE__), 'tmux.dot')
TMUX_FILES    = %w(tmux tmuxinator)

GIT_ROOT      = File.join(File.dirname(__FILE__), 'git')
GIT_FILES     = `ls git`.split("\n").freeze

ETC_ROOT      = File.join(File.dirname(__FILE__), 'etc')
ETC_FILES     = `ls etc`.split("\n").freeze

ARCH_ROOT     = File.join(File.dirname(__FILE__), 'arch')
ARCH_FILES    = `ls arch`.split("\n").freeze

CONFIG_ROOT   = File.join(File.dirname(__FILE__), 'config')

MIKUTTER_ROOT = File.join(File.dirname(__FILE__), 'mikutter')

CLEANS = %w(
  .agignore
  .bundle
  .config/fish
  .config/nvim
  .dircolors
  .gemrc
  .gitconfig
  .global_ignore
  .helpers
  .peco
  .pryrc
  .railsrc
  .tigrc
  .tmux
  .tmux.conf
  .tmuxinator
  .vim
  .vimrc
  .vimrc.apperance
  .vimrc.basic
  .vimrc.colors
  .vimrc.completion
  .vimrc.completion.autocomplpop
  .vimrc.completion.neocomplcache
  .vimrc.editing
  .vimrc.encoding
  .vimrc.indent
  .vimrc.misc
  .vimrc.moving
  .vimrc.plugin
  .vimrc.plugins_setting
  .vimrc.search
  .vimrc.statusline
  .zshrc
  .zshrc.alias
  .zshrc.config
  .zshrc.env
  .zshrc.function
  .zshrc.linux
  .zshrc.local
  .zshrc.osx
  .zshrc.setting
).freeze

CLEAN.concat(CLEANS.map { |c| File.join(HOME, c) })

task default: :deploy

desc 'Create symbolic links for the all dotfiles'
task deploy: %w(zsh:link vim:link git:link tmux:link etc:link config:sync)

namespace :zsh do
  desc 'Create symbolic links for zsh settings file to HOME'
  task :link do
    _symlink File.join(ZSH_DOT_ROOT, 'zshrc'), File.join(HOME, '.zshrc')
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
  desc 'Create a symbolic link for tmux libraries'
  task :link do
    _symlink File.join(TMUX_ROOT), File.join(HOME, '.tmux')
    _symlink File.join(TMUX_DOT_ROOT, 'tmuxinator'), File.join(HOME, '.tmuxinator')
  end

  namespace :osx do
    desc 'Create symbolic links for tmux config files for OS X to HOME'
    task :link do
      _symlink File.join(TMUX_DOT_ROOT, 'tmux.conf.osx'), File.join(HOME, '.tmux.conf')
    end
  end

  namespace :linux do
    desc 'Create symbolic links for tmux config files for Linux to HOME'
    task :link do
      _symlink File.join(TMUX_DOT_ROOT, 'tmux.conf.linux'), File.join(HOME, '.tmux.conf')
    end
  end
end

namespace :etc do
  desc 'Create symbolic links  for etcs link to HOME'
  task :link do
    same_name_symlinks ETC_ROOT, ETC_FILES
  end
end

namespace :arch do
  desc 'Create symbolic links for ArchLinux to HOME'
  task :link do
    same_name_symlinks ARCH_ROOT, ARCH_FILES
  end
end

namespace :config do
  desc 'Sync config files'
  task :sync do
    sh "rsync -av #{CONFIG_ROOT}/* #{File.join(HOME, '.config/')} &> /dev/null"
  end
end

namespace :mikutter do
  desc 'Sync config files'
  task :sync do
    sh "rsync -av #{MIKUTTER_ROOT}/* #{File.join(HOME, '.mikutter/')} &> /dev/null"
  end
end

def _symlink(file, dest)
  symlink file, dest unless File.exist?(dest)
end

def same_name_symlinks(root, files)
  files.each do |file|
    _symlink File.join(root, file), File.join(HOME, '.' + file)
  end
end
