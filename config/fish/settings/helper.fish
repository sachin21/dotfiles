# Print Colored messages
# ---------------------------------------------------**
function message
  printf "\033[34m$argv\033[m\n"
end

function warn
  printf  "\033[33m$argv\033[m\n"
end

function succeed
  printf "\033[37m$argv\033[m\n"
end

function fail
  printf "\033[31m$argv\033[m\n"
end

function ask
  printf "\033[35m$argv\033[m\n"
end

# Utilities
# ---------------------------------------------------**
function command_exists
  type $argv > /dev/null ^&1
end
