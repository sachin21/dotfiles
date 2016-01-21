# Add ENVs for Homebrew
# ---------------------------------------------------**
set PATH $PATH /usr/local/heroku/bin

set -x HOMEBREW_CASK_OPTS "--appdir /Applications"
set -x CC "/usr/local/bin/gcc-4.8"

# Add etc aliases
# ---------------------------------------------------**
alias gcc "/usr/local/bin/gcc-4.8"
alias o "open"
alias o. "open ."

# If exists, setup for etc
# ---------------------------------------------------**
if command_exists brew
  set PATH $PATH (brew --prefix coreutils)/libexec/gnubin
else
  warn "  x [Warning] Homebrew is not installed"
end

if command_exists gls
  alias ls "gls --color=auto -AFh"
else
  warn "  x [Warning] coreutils is not installed"
  alias ls "ls -AFh"
end

if command_exists rmtrash
  alias rm rmtrash
else
  warn "  x [Warning] rmtrash is not installed"
end
