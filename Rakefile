require 'rake/clean'

HOME = ENV['HOME']

ZSH_DOT_ROOT  = File.join(File.dirname(__FILE__), 'zsh.dot')
ZSH_ROOT      = File.join(File.dirname(__FILE__), 'zsh')
VIM_ROOT      = File.join(File.dirname(__FILE__), 'vim')
VIM_DOT_ROOT  = File.join(File.dirname(__FILE__), 'vim.dot')
TMUX_ROOT     = File.join(File.dirname(__FILE__), 'tmux')
TMUX_DOT_ROOT = File.join(File.dirname(__FILE__), 'tmux.dot')
GIT_ROOT      = File.join(File.dirname(__FILE__), 'git')
ETC_ROOT      = File.join(File.dirname(__FILE__), 'etc')

GIT_FILES = %w(
  gitconfig
  global_ignore
).freeze

ETC_FILES = %w(
  bundle
  dircolors
  gemrc
  peco
  pryrc
  tigrc
  railsrc
  agignore
).freeze

TMUX_FILES = %w(
  tmux.conf
  tmuxinator
)

CLEANS = %w(
  .zsh
  .zshrc
  .tmux
  .tmuxinator
  .tmux.conf
  .vim
  .vimrc
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
  .vimrc.gitlogviewer
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

).freeze

VIM_DOT_FILES = %w(
  vimrc
  vimrc.apperance
  vimrc.basic
  vimrc.bundle
  vimrc.colors
  vimrc.completion
  vimrc.completion.autocomplpop
  vimrc.completion.neocomplcache
  vimrc.editing
  vimrc.encoding
  vimrc.gitlogviewer
  vimrc.indent
  vimrc.misc
  vimrc.moving
  vimrc.plugins_setting
  vimrc.search
  vimrc.statusline
)

CLEAN.concat(CLEANS.map { |c| File.join(HOME, c) })

task default: :all
task all: ['zsh:link', 'vim:link', 'git:link', 'tmux:link', 'etc:link']

namespace :zsh do
  desc 'Create symbolic for zsh settings file link to HOME'
  task :link do
    symlink_ File.join(ZSH_DOT_ROOT, 'zshrc'), File.join(HOME, '.zshrc')
    symlink_ File.join(ZSH_ROOT), File.join(HOME, '.zsh')
  end
end

namespace :vim do
  desc 'Create symbolic for vimrc link to HOME'
  task :link do
    symlink_ File.join(VIM_ROOT), File.join(HOME, '.vim')
    symlink_ File.join(VIM_DOT_ROOT, 'vimrc'), File.join(HOME, '.vimrc')
    same_name_symlinks VIM_DOT_ROOT, VIM_DOT_FILES
  end
end

namespace :git do
  desc 'Create symbolic for git files link to HOME'
  task :link do
    same_name_symlinks GIT_ROOT, GIT_FILES
  end
end

namespace :tmux do
  desc 'Create symbolic for tmux settings file for link to HOME'
  task :link do
    symlink_ File.join(TMUX_ROOT), File.join(HOME, '.tmux')
    same_name_symlinks TMUX_DOT_ROOT, TMUX_FILES
  end
end

namespace :etc do
  desc 'Create symbolic for etcs link to HOME'
  task :link do
    same_name_symlinks ETC_ROOT, ETC_FILES
  end
end

def symlink_(file, dest)
  symlink file, dest unless File.exist?(dest)
end

def same_name_symlinks(root, files)
  files.each do |file|
    symlink_ File.join(root, file), File.join(HOME, '.' + file)
  end
end
