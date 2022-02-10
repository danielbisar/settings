#!/bin/bash

# installs neovim without the need of root access; works also in docker containers
function neovim-install()
{
    mkdir ~/.db
    pushd ~/.db > /dev/null
    wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
    wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage.sha256sum

    sha256sum -c nvim.appimage.sha256sum
    echo press ctrl-c to abort or return if the sum is okay
    read

    chmod +x nvim.appimage
    ln -s ./nvim.appimage nvim
    popd > /dev/null
}

