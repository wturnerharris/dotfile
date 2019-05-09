#!/bin/bash

####################################################################
## This script is meant to run on Mac OS X; therefore some arch-spec
## issues could arise if used on a non-mac or non-unix environment.
####################################################################

# Terminal colors
DEFAULT=$(tput setaf 7 -T xterm)
RED=$(tput setaf 1 -T xterm)
GREEN=$(tput setaf 2 -T xterm)
YELLOW=$(tput setaf 3 -T xterm)
BLUE=$(tput setaf 4 -T xterm)
BOLD=$(tput bold -T xterm)
RESET=$(tput sgr0 -T xterm)
DIM=$(tput dim -T xterm)
# begin underline mode
SMUL=$(tput smul -T xterm)
# exit underline mode
RMUL=$(tput rmul -T xterm)
# up x lines
U1=$(tput cuu 1 -T xterm)
#EOL
EL=$(tput el -T xterm)
OK="${GREEN}ok${DEFAULT}"
DONE="${GREEN}done${DEFAULT}"

SOURCE_REPO_URL="git@github.com:wturnerharris/.dotfiles.git"
SOURCE="$HOME/.dotfiles"
FILES=(
  "bash_aliases"
  "hyper.js"
  "gitconfig"
  "gitignore_global"
  "vimrc"
)

# Clone the source dotfile repo.
echo "${YELLOW}Cloning or updating source...${DEFAULT}"
if ! [ -d "$SOURCE/.git" ]; then
  git clone $SOURCE_REPO_URL $SOURCE
else 
  cd $SOURCE
  git fetch && git pull
fi

# Install or update vim with brew. Autocompletion requires that it be installed with Lua.
# Consider using https://github.com/lifepillar/vim-mucomplete to reduce the Lua dependency.
FIND_BREW_VIM=$(brew list | xargs -L1 echo | grep vim)
if [ $? > 0 ]; then 
  echo "${YELLOW}Installing vim with brew...${DEFAULT}"
  brew update
  brew install vim
  brew upgrade vim
  echo $DONE
fi

echo "${YELLOW}Backing up existing dotfiles and creating symlinks...${DEFAULT}"
for File in "${FILES[@]}"
do 
  if ! [[ -L "$HOME/.$File" && -f "$HOME/.$File" ]]; then
    # Backup existing
    BACKUP=$(mv "$HOME/.$File" "$HOME/.$File.bak")

    # Create symlinks
    ln -s "$SOURCE/$File" "$HOME/.$File"
  fi
done
echo $DONE

# For more info, check out [the repo](https://github.com/junegunn/vim-plug), otherwise just use the CURL below.
echo "${YELLOW}Installing Vim Plug...${DEFAULT}"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo $DONE

# Install plugins:
echo "${YELLOW}Installing vim plugins...${DEFAULT}"
vim +'PlugInstall --sync' +qa
echo $DONE

WRITE_ALIASES=$(cat ~/.bashrc | grep bash_aliases)
if [ $? > 0 ]; then
  echo "${YELLOW}Adding bash_aliases to bashrc file...${DEFAULT}"
  echo "source ~/.bash_aliases" >> ~/.bashrc
fi
echo $DONE
