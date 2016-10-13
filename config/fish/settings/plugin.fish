# For rbenv
# ---------------------------------------------------**
if [ -d "$HOME/.rbenv" ]
  set -x PATH $HOME/.rbenv/bin $PATH
  set -x PATH $HOME/.rbenv/shims $PATH
  source (rbenv init - | psub)
else
  warn "  x [Warning] rbenv is not installed"
end

# For pyenv
# ---------------------------------------------------**
if [ -d "$HOME/.pyenv" ]
  set -x PATH $HOME/.pyenv/bin $PATH
  set -x PATH $HOME/.pyenv/shims $PATH
  source (pyenv init - | psub)
else
  warn "  x [Warning] pyenv is not installed"
end

# For nodenv
# ---------------------------------------------------**
if [ -d "$HOME/.nodenv" ]
  set -x PATH $HOME/.nodenv/bin $PATH
  set -x PATH $HOME/.nodenv/shims $PATH
  source (nodenv init - | psub)
else
  warn "  x [Warning] nodenv is not installed"
end

# For tmux
# ---------------------------------------------------**
if command_exists tmux
  export TMUX_POWERLINE_SEG_WEATHER_LOCATION="26237038"
else
  warn "  x [Warning] tmux is not installed"
end

# For autojump
# ---------------------------------------------------**
if [ -e /usr/local/share/autojump/autojump.fish ]
  source /usr/local/share/autojump/autojump.fish
else
  warn "  x [Warning] autojump is not installed"
end
