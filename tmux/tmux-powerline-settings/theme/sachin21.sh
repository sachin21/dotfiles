TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}


# Format: segment_name background_color foreground_color [non_default_separator]

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
  TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "tmux_session_info 148 234" \
    "hostname 33 0" \
    "lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
    "wan_ip 24 255" \
    "vcs_branch 29 88" \
  )
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
  TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "date_day 235 136" \
    "date 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
    "time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
  )
fi
