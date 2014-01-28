# etc
export PATH=/usr/local/bin:$PATH
export CC=/usr/bin/gcc-4.2
export CC=/usr/bin/gcc
export EDITOR=vim
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# oh my zsh
ZSH_THEME_GIT_PROMPT_PREFIX=" ☁  %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ☂" # Ⓓ
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭" # ⓣ
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ☀" # Ⓞ
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✚" # ⓐ ⑃
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ⚡"  # ⓜ ⑁
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖" # ⓧ ⑂
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➜" # ⓡ ⑄
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ♒" # ⓤ ⑊

plugins=(git ruby rails gem brew history)
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/.zshrc.colors
source ~/dotfiles/.zshrc.alias
