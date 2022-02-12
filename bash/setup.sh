#!/bin/bash

. "$(cd "$(dirname "$BASH_SOURCE") && pwd)"/vars.sh


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

