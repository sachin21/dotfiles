# set paths for Linux
# ---------------------------------------------------**
set PATH $PATH "$HOME/.linuxbrew/bin"

set -x MANPATH "$HOME/.linuxbrew/share/man:$MANPATH"
set -x INFOPATH "$HOME/.linuxbrew/share/info:$INFOPATH"

# Add aliases for clipboard
# ---------------------------------------------------**
if command_exists xsel
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
else
  warn "  x [Warning] xsel is not installed"
end

if command_exists gls
  alias ls='gls --color=auto -F'
else
  warn "  x [Warning] coreutils is not installed"
  alias ls='ls -F'
end
