require 'rake/clean'

HOME = ENV['HOME']

DOT_ZSH_FILES = `ls dot.zsh`.split("\n").freeze
DOT_ZSH_ROOT  = File.join(File.dirname(__FILE__), 'dot.zsh')

DOT_TMUX_ROOT = File.join(File.dirname(__FILE__), 'dot.tmux')
TMUX_FILES    = %w(tmux tmuxinator).freeze
TMUX_ROOT     = File.join(File.dirname(__FILE__), 'tmux')

GIT_ROOT      = File.join(File.dirname(__FILE__), 'git')
GIT_FILES     = `ls git`.split("\n").freeze

ETC_ROOT      = File.join(File.dirname(__FILE__), 'etc')
ETC_FILES     = `ls etc`.split("\n").freeze

ARCH_ROOT     = File.join(File.dirname(__FILE__), 'arch')
ARCH_FILES    = `ls arch`.split("\n").freeze

CONFIG_ROOT   = File.join(File.dirname(__FILE__), 'config')

MIKUTTER_ROOT = File.join(File.dirname(__FILE__), 'mikutter')

DROP = '&> /dev/null'.freeze

CLEANS = %w(
  .agignore
  .bundle
  .config/fish
  .config/nvim/nvimrc.*
  .dircolors
  .gemrc
  .gitconfig
  .global_ignore
  .helpers
  .hyper.js
  .peco
  .pryrc
  .railsrc
  .tigrc
  .tmux
  .tmux.conf
  .tmuxinator
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
  .zshrc.tmux
).freeze

CLEAN.concat(CLEANS.map { |c| File.join(HOME, c) })

task default: :deploy

desc 'Create symbolic links for the all dotfiles'
task deploy: %w(zsh:link git:link tmux:link etc:link config:sync)

namespace :zsh do
  desc 'Create symbolic links for zsh settings file to HOME'
  task :link do
    _symlink File.join(DOT_ZSH_ROOT, 'zshrc'), File.join(HOME, '.zshrc')
    same_name_symlinks DOT_ZSH_ROOT, DOT_ZSH_FILES
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
    _symlink \
      File.join(DOT_TMUX_ROOT, 'tmuxinator'),
      File.join(HOME, '.tmuxinator')
  end

  namespace :osx do
    desc 'Create symbolic links for tmux config files for OS X to HOME'
    task :link do
      _symlink \
        File.join(DOT_TMUX_ROOT, 'tmux.conf.osx'), File.join(HOME, '.tmux.conf')
    end
  end

  namespace :linux do
    desc 'Create symbolic links for tmux config files for Linux to HOME'
    task :link do
      _symlink \
        File.join(DOT_TMUX_ROOT, 'tmux.conf.linux'),
        File.join(HOME, '.tmux.conf')
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
    sh "rsync -av #{CONFIG_ROOT}/* #{File.join(HOME, '.config/')} #{DROP}"
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
