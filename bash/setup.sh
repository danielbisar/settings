#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SETTINGS_BASE="$DIR"

if [[ ! -L ~/.vimrc ]]; then
    echo setting up .vimrc sym-link
    if [[ -f ~/.vimrc ]]; then
        mv ~/.vimrc ~/.vimrc.orignal
    fi
    ln -s "$SETTINGS_BASE"/../vim/common.vim ~/.vimrc
fi

if [[ ! -L ~/.config/nvim/init.vim ]]; then
    echo setting up nvim init.vim symlink
    mkdir -p ~/.config/nvim
    mv ~/.config/nvim/init.vim init.vim.original
    ln -s "$SETTINGS_BASE"/../vim/common.vim ~/.config/nvim/init.vim
fi

hasBashRcEnv=$(cat ~/.bashrc | grep '. $SETTINGS_BASE/environment.sh')

if [[ -z "$hasBashRcEnv" ]]; then
    echo "add env to bashrc"
    echo ". $SETTINGS_BASE/environment.sh" >> ~/.bashrc
fi

