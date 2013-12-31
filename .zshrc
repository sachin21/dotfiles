# etc
export CC=/usr/bin/gcc-4.2
export CC=/usr/bin/gcc
export EDITOR
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH=/usr/local/bin:$PATH

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# oh_my_zsh

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

plugins=(git ruby rails gem brew)
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/.zshrc.colors
source ~/dotfiles/.zshrc.alias
