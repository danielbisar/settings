#!/bin/bash

. "$(dirname "BASH_SOURCE")/vars.sh"

function neovim-install-without-sudo()
{
    echo Install without sudo
    return

    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null
    wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
    wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage.sha256sum

    sha256sum -c nvim.appimage.sha256sum
    echo press ctrl-c to abort or return if the sum is okay
    read

    chmod +x nvim.appimage
    ln -s ./nvim.appimage nvim
    popd > /dev/null
}

function neovim-install-with-sudo()
{
    echo Install with sudo
    return
}

function neovim-install-dependencies()
{
    sudo apt install fzf ripgrep shellcheck
    # without root access (TODO)
    # - https://github.com/junegunn/fzf/releases/download/0.29.0/fzf-0.29.0-linux_amd64.tar.gz

    # python3 and pynvim
    sudo apt install python3 python3-pip
    pip3 install pynvim             # if not installed yet
    sudo pip3 install --upgrade pynvim   # upgrade if was already installed

    # nodejs latest
    curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install nodejs 
    sudo npm -g install neovim
}


function neovim-install()
{
    read -p "Do you have sudo available: " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        neovim-install-without-sudo
    else
        neovim-install-with-sudo
    fi
}


