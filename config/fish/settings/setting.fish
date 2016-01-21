# Add aliases for clipboard
# ---------------------------------------------------**
if command_exists pbcopy
  # OS X
  alias copy 'pbcopy'
else if command_exists xsel
  # Linux
  alias copy 'xsel --clipboard --input'
else
  warn "  x [Warning] Copy command is not installed"
end
