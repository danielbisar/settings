#!/bin/bash

if [[ -z "$SETTINGS_BASE" ]]; then
    export SETTINGS_BASE="$(dirname "${BASH_SOURCE[0]}")/.."
fi

if [[ ! -L ~/.vimrc ]]; then
    echo setting up .vimrc sym-link
    mv ~/.vimrc ~/.vimrc.orignal
    ln -s "$SETTINGS_BASE"/../vim/common.vim .vimrc
fi

if [[ ! -L ~/.config/nvim/init.vim ]]; then
    echo setting up nvim init.vim symlink
    mkdir -p ~/.config/nvim
    ln -s "$SETTINGS_BASE"/../vim/common.vim ~/.config/nvim/init.vim
fi

hasBashRcEnv=$(cat ~/.bashrc | grep '. $SETTINGS_BASE/environment.sh')

if [[ -z "$hasBashRcEnv" ]]; then
    echo "add env to bashrc"
    echo ". $SETTINGS_BASE/environment.sh" >> ~/.bashrc
fi

