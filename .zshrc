source ~/dotfiles/tmux/tmuxinator.zsh
source ~/dotfiles/zsh.dot/zshrc.env
source ~/dotfiles/zsh.dot/zshrc.config
source ~/dotfiles/zsh.dot/zshrc.settings
source ~/dotfiles/zsh.dot/zshrc.zaw
source ~/dotfiles/zsh.dot/zshrc.colors
source ~/dotfiles/zsh.dot/zshrc.alias
source ~/dotfiles/zsh.dot/zshrc.functions

case "${OSTYPE}" in
  darwin*)
    source ~/dotfiles/zsh.dot/zshrc.osx
    ;;

  linux*)
    source ~/.zsh/zshrc.linux
    ;;
esac
