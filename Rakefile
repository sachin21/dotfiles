require 'rake/clean'

OS = `uname`
HOME = ENV['HOME']

ZSH_DOT_ROOT = File.join(File.dirname(__FILE__), 'zsh.dot')
ZSH_ROOT     = File.join(File.dirname(__FILE__), 'zsh')
VIM_ROOT     = File.join(File.dirname(__FILE__), 'vim.dot')
TMUX_ROOT    = File.join(File.dirname(__FILE__), 'tmux')
GIT_ROOT     = File.join(File.dirname(__FILE__), 'git')
ETC_ROOT     = File.join(File.dirname(__FILE__), 'etc')

ETC_FILES = %w( bundle dircolors gemrc pryrc )

CLEANS = [
  '.zsh',
  '.zshrc',
  '.tmux.conf',
  '.gitconfig',
  '.gemrc',
  '.pryrc',
  '.bundle',
  '.dircolors'
].freeze

CLEAN.concat(CLEANS.map { |c| File.join(HOME, c) })

task default: :all
task all: ['zsh:link', 'vim:link', 'git:link', 'tmux:link', 'etc:link']

namespace :zsh do
  desc 'Create symbolic link to HOME'
  task :link do
    symlink_ File.join(ZSH_DOT_ROOT, 'zshrc'), File.join(HOME, '.zshrc')
    symlink_ File.join(ZSH_ROOT), File.join(HOME, '.zsh')
  end
end

namespace :vim do
  desc 'Create symbolic link to HOME'
  task :link do
    symlink_ File.join(VIM_ROOT, 'vimrc'), File.join(HOME, '.vimrc')
  end
end

namespace :git do
  desc 'Create symbolic link to HOME'
  task :link do
    symlink_ File.join(GIT_ROOT, 'gitconfig'), File.join(HOME, '.gitconfig')
  end
end

namespace :tmux do
  desc 'Create symbolic link to HOME'
  task :link do
    symlink_ File.join(TMUX_ROOT, 'tmux.conf'), File.join(HOME, '.tmux.conf')
  end
end

namespace :etc do
  desc 'Create symbolic link to HOME'
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
