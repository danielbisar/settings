#!/bin/bash

. "$(cd "$(dirname "$BASH_SOURCE") && pwd)"/vars.sh


if [[ ! -L ~/config/kitty/kitty.conf ]]; then
    echo create kitty.conf symlink
    mkdir -p ~/.config/kitty
    mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.original
    ln -s "$SETTINGS_BASE"/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi

BASH_ENV_PATH="${DB_SETTINGS_BASH_BASE}environment.sh"

hasBashRcEnv=$(cat ~/.bashrc | grep ". $BASH_ENV_PATH")

if [[ -z "$hasBashRcEnv" ]]; then
    echo "add env to bashrc"
    echo ". $BASH_ENV_PATH" >> ~/.bashrc
fi

