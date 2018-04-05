#!/bin/bash

### bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

### local setup and settings
echo "Hello, $USER."

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
#export PROMPT_COMMAND='history -n;'

