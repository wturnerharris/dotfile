#!/bin/bash

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
