if [[ ! -n $TMUX ]]; then
  ids=$(tmuxinator list | tail -n 1 | sed -e 's/ /'"\n"'/g' | grep -v '^\s*$')

  create_new_session="Create new session"
  ids="$ids\n${create_new_session}:"
  session="$(echo $ids | peco)"

  if [[ "$session" = "$create_new_session" ]]; then
    tmux new-session
  elif [[ -n "$session" ]]; then
    tmuxinator "$session"
  else
    :
  fi
fi
