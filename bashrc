#!/bin/bash

### executable functions

# Update master branch from remote
gituptodate() {

  # update all remotes and branches
  git fetch --all 

  # what's the commit of your local master?
  LOCAL_MASTER=$(git rev-parse master)

  # what's the commit of the origin master?
  REMOTE_MASTER=$(git rev-parse origin/master)
 
  if [ "$LOCAL_MASTER" != "$REMOTE_MASTER" ]; then
    git checkout master
    git reset --hard $REMOTE_MASTER
    echo "Updating local master branch "$(echo $LOCAL_MASTER | cut -c1-7)" with "$(echo $REMOTE_MASTER | cut -c1-7)
    git status
  fi
}

# Hide files in Mac
hide() {
  if [ $# -eq 1 ] && [ "$1" = "help" ]
    then
      echo "Usage:"
      echo "  hide on path_to_file"
      echo "  hide off path_to_file"
      return
  fi
  if [ $# -lt 2 ]
    then
      echo "Not Enough Arguments Supplied"
      return
  fi
  if [ "$1" = "on" ]
    then
      ON="hidden"
  else
    ON="nohidden"
  fi
  sudo chflags $ON $2
}

# Open a finder window with root priv
finder() {
  sudo /System/Library/CoreServices/Finder.app/Contents/MacOS/Finder &
}

# bash completion for the `terminus` command

_terminus_complete() {
  local cur=${COMP_WORDS[COMP_CWORD]}

  IFS=$'\n';  # want to preserve spaces at the end
  local opts=( $(terminus cli completions --line="$COMP_LINE" --point="$COMP_POINT") )

  if [[ $opts = "<file>" ]]
  then
    COMPREPLY=( $(compgen -f -- $cur) )
  else
    COMPREPLY=$opts
  fi
}

complete -o nospace -F _terminus_complete terminus

### executable aliases

# Delete all but the master branch
alias gittyup='git branch | grep -v "master" | xargs git branch -D'

# Grab the pub ssh key
alias sshkey='cat ~/.ssh/id_rsa.pub | pbcopy'

# Max 4 pings by default
alias ping='ping -c 4'

# Show IP Address
alias ipaddr="echo $(curl -s checkip.dyndns.org | sed -e 's/.*IP: //' -e 's/<.*$//')"
alias ipaddr2='curl ipecho.net/plain ; echo'

# Flush DNS
alias flushdns='sudo killall -HUP mDNSResponder'

# Update brew, upgrade brew, cleanup brew
alias brewski='brew update && brew upgrade --all && brew cleanup; brew cask cleanup; brew doctor; brew prune'

# Update brew manually
alias brewuptodate='cd "$(brew --repository)" && git fetch && git reset --hard origin/master'

# Run rake
alias brake="bundle exec rake"

# Start postgres
alias pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'

# Connect to work if logged in to VPN
alias barrel='ssh wes.turner@10.0.1.214'

### Paths
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=$PATH:$HOME/.bin

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:/usr/local/apache-ant-1.9.4/bin

# Node
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$HOME/.node_modules/bin:$PATH

# Ruby
export RUBY_CFLAGS="-march=native -O3"
export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# MongoDB
export PATH=$PATH:/usr/local/mongodb/bin

# PHP7 CLI (brew)
export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
