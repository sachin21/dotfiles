# Common
# ---------------------------------------------------**
alias reload 'exec $SHELL'
alias ts 'tmux split-window'
alias th 'tmux split-window -h'
alias CC 'gcc'
alias bi 'bundle install --path=./vendor/bundle -j8'
alias v 'vim'
alias vi 'vim'
alias fs 'bundle exec foreman start'
alias quit 'exit'
alias t 'tmux'
alias allunigem 'gem list --no-versions | grep "^[a-z]" | grep bunlder -v | grep space2underscore -v | grep space2dot -v | grep test-unit -v | grep rdoc -v | grep rake -v | grep psych -v | grep io-console -v | grep json -v | grep bigdecimal -v | grep minitest -v | xargs gem uninstall -aIx'
alias n 'noglob'
alias sp 'rails s puma'
alias sl 'ls'
alias pw 'ping 8.8.8.8'
alias va 'vagrant'
alias gto 'git open'
alias tn 'tmux new'
alias memo 'cat > /dev/null'
alias gs 'git sync'
alias gsm 'git syncm'
alias b 'bundle'
alias tigj 'tig'
alias rehash 'rbenv rehash; nodenv rehash; pyenv rehash'
alias ctags "ctags --exclude=.git --exclude=log"

# Global
# ---------------------------------------------------**
function bind_global_alias
  switch (commandline -t)
  case "a"
    commandline -rt '| ag'
  case "l"
    commandline -rt '| less'
  case "n"
    commandline -rt '> /dev/null'
  case "na"
    commandline -rt '&> /dev/null'
  case "s"
    commandline -rt '| sort'
  case "v"
    commandline -rt "| vim -R -"
  case "w"
    commandline -rt '| wc'
  case "x"
    commandline -rt '| xargs'
  end
end

bind \cx bind_global_alias

# Alias for projects
# ---------------------------------------------------**
for project in (command ls "$HOME/.tmuxinator")
  set project (echo $project | sed 's/\.[^.]*$//')
  alias $project "tmuxinator $project"
end
set --erase project
