#!/bin/bash

### bashrc
if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

### private file for anything secret
if [ -f ~/.bash_private ]; then source ~/.bash_private; fi

### aliases
if [ -f ~/.bash_aliases ]; then source ~/.bash_aliases; fi

### local setup and settings
echo "Hello, $USER."