#!/bin/bash

### executable functions
adduser()
{
  if [ -z "$1" ]                           # Is parameter #1 zero length?
   then
     echo "-Parameters are zero length.-"  # Or no parameter passed.
   else
     echo "-Parameter #1 is \"$1\".-"
   fi
  if [ -z "$2" ]                           # Is parameter #2 zero length?
   then
     echo "-Parameters are zero length.-"  # Or no parameter passed.
   else
     echo "-Parameter #2 is \"$2\".-"
     sudo dseditgroup -o edit -a $1 -t user $2
   fi
}

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

# Delete all but the master branch
alias gittyup='git branch | grep -v "master" | xargs git branch -D'
# Max 4 pings by default
alias ping='ping -c 4'
# Show IP Address
alias ipaddr="echo $(curl -s checkip.dyndns.org | sed -e 's/.*IP: //' -e 's/<.*$//')"
alias ipaddr2='curl ipecho.net/plain ; echo'
# Flush DNS
alias flushdns='sudo killall -HUP mDNSResponder'
# Brew stuff
alias brewski='brew update && brew upgrade --all && brew cleanup; brew cask cleanup; brew doctor; brew prune'
alias brewuptodate='cd "$(brew --repository)" && git fetch && git reset --hard origin/master'
# Ruby stuff
alias brake="bundle exec rake"
# Start postgres
alias pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
# Connect to work if logged in to VPN
alias sites='cd ~/Sites'
alias hosts='sudo vim /etc/hosts'
alias bump='git commit -am "Update changelog and bump versions"'
alias sync_basic='git push origin develop; git checkout master; git push origin master; git push origin $(version)'
alias sync_pantheon='git checkout develop && git push origin develop && git checkout master && git push origin master && git push pantheon master; git push origin $(version)'
alias sync_wpe='git checkout develop && git push origin develop && git checkout master && git push origin master && git push live master'
alias sync_acquia='git checkout develop && git push origin develop && git push acquia develop && git checkout master && git push origin master && git push acquia master'
alias homevpn='sudo openvpn --config ~/.openvpn/client3.ovpn --ca ~/.openvpn/ca.crt --cert ~/.openvpn/client.crt --key ~/.openvpn/client.key'
alias docker-kill-all='docker ps --format "{{.ID}}" | xargs docker kill'
alias octal='stat -f %Mp%Lp *'
alias sshkey='cat ~/.ssh/id_rsa.pub | pbcopy'
alias ssh-fingerprint='ssh-keygen -E md5 -lf'
alias shrug='echo "¯\_(ツ)_/¯" | pbcopy'
alias b='git rev-parse --abbrev-ref HEAD'
alias version='git tag --sort v:refname | grep "^v" | tail -1'
alias test-tag='git tag --sort v:refname | grep _test_ | tail -1'
alias live-tag='git tag --sort v:refname | grep _live_ | tail -1'
alias increment="perl -pe 's/([0-9]+)\b/0\$1~01234567890/g' | perl -pe 's/0(?!9*~)|([0-9])(?=9*~[0-9]*?\1([0-9]))|~[0-9]*/\$2/g'"
alias increment-test='t=$(test-tag); p="pantheon_test_"; v=${t:${#p}}; echo $(($v+1))'
alias increment-live='t=$(live-tag); p="pantheon_live_"; v=${t:${#p}}; echo $(($v+1))'
alias pantheon-deploy-test='p="pantheon_test_"$(increment-test) && git tag $p && git push pantheon $p'
alias pantheon-deploy-live='p="pantheon_live_"$(increment-live) && git tag $p && git push pantheon $p'
alias force-push='git push -f origin $(b)'
alias push='git push origin `b`'
alias php-syntax='git diff --diff-filter=ACMR --name-only origin/master | grep .php | xargs -L1 php -l'
alias process='git commit -am "Process scripts and/or styles"'
alias terminus-login='terminus auth:login --machine-token=$PANTHEON_TOKEN'
alias lando-login='lando terminus auth:login --machine-token=$PANTHEON_TOKEN'
alias nukenode='rm -rf node_modules/ ; npm i; npm run build'
alias spy='sudo arp-scan --interface=en0 --localnet'
alias db='terminus site:pc --app=sequelpro $(basename `pwd`)".develop"'
alias git-diff='git diff --ignore-space-change'
alias list-multidevs='terminus multidev:list $(basename `pwd`) --field=Name'
