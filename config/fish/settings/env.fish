# ENV
# ---------------------------------------------------**
setenv PATH /usr/local/bin $PATH
setenv PATH /usr/local/sbin $PATH
setenv PATH "$HOME/dotfiles/bin" $PATH
setenv PATH "$GOPATH/bin" $PATH

setenv GOPATH "$HOME/.go"

setenv EDITOR vim
setenv SHELL zsh

setenv PARALLEL_TEST_PROCESSORS 8
setenv MAKEOPTS -j8
setenv USE_SYSTEM_LIBRARIES 1
setenv LIBRARY_PATH /usr/local/lib /usr/lib
setenv PORT 3000
setenv PGDATA /usr/local/var/postgres

# Tmux
# ---------------------------------------------------**
setenv TMUX_POWERLINE_THEME sachin21
setenv TMUX_POWERLINE_DIR_USER_THEMES "$HOME.tmux/tmux-powerline-settings/theme"
