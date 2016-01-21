# Useful functions
# ---------------------------------------------------**

function agvim
  eval vim (ag $argv | peco --query "$LBUFFER" | awk -F: '{print "-c",$2,$1}')
end

function _peco_select_repository
  ghq list -p | peco | read line
  cd $line
end

function _peco_select_history
  history | peco | read line; commandline $line
end

function python_listup
  pyenv install --list | peco | sed -e 's/^  *//g' | tr -d '\n" "' | copy
  succeed "  + Copied to the clipboard"
end

function ruby_listup
  rbenv install --list | peco | sed -e 's/^  *//g' | tr -d '\n" "' | copy
  succeed "  + Copied to the clipboard"
end

function ec
  git commit -m "Execute '$argv'"
end
