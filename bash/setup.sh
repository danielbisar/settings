#!/bin/bash

REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
SETTINGS_BASE="$REPO_ROOT"

if [[ ! -L ~/.vimrc ]]; then
    echo setting up .vimrc sym-link
    if [[ -f ~/.vimrc ]]; then
        mv ~/.vimrc ~/.vimrc.orignal
    fi
    ln -s "$SETTINGS_BASE"/vim/common.vim ~/.vimrc
fi

if [[ ! -L ~/.config/nvim/init.vim ]]; then
    echo setting up nvim init.vim symlink
    mkdir -p ~/.config/nvim
    mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.original
    ln -s "$SETTINGS_BASE"/vim/common.vim ~/.config/nvim/init.vim
fi

if [[ ! -L ~/config/kitty/kitty.conf ]]; then
    echo create kitty.conf symlink
    mkdir -p ~/.config/kitty
    mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.original
    ln -s "$SETTINGS_BASE"/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi

# TODO escape path for regex
hasBashRcEnv=$(cat ~/.bashrc | grep ". $SETTINGS_BASE/bash/environment.sh")

if [[ -z "$hasBashRcEnv" ]]; then
    echo "add env to bashrc"
    echo ". $SETTINGS_BASE/bash/environment.sh" >> ~/.bashrc
fi

