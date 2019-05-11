#!/bin/bash

##############################
####  BASH CONFIG/EXPORTS  ###
##############################

export TERM=xterm

# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n\$ '

## Auto merge without commit message
export GIT_MERGE_AUTOEDIT=no

### bash history improvements

# Append history file rather then overwrite it
shopt -s histappend

# Don't put duplicate lines in history
export HISTCONTROL=ignoredups

# Store 1000 commands in bash history
export HISTFILESIZE=2000
export HISTSIZE=2000

# Store when a command was used for the last time
export HISTTIMEFORMAT='%F %T '

# Ignore pwd history
export HISTIGNORE="pwd:history"

# Pull in any newly written lines, allowing to share history within active sessions
export PROMPT_COMMAND='history -n;'

### Paths
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:$HOME/.composer/vendor/bin

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:/usr/local/apache-ant-1.9.4/bin

# Node
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$HOME/.node_modules/bin:$PATH

### Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

### fire up nvm
if [ -d ~/.nvm ]; then 
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
fi
source ~/.bash_aliases
