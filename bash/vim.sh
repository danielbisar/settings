#!/bin/bash

. "$(realpath $(dirname "$BASH_SOURCE"))/vars.sh"

function neovim-install()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    VERSION="v0.6.1"

    wget https://github.com/neovim/neovim/releases/download/$VERSION/nvim.appimage
    wget https://github.com/neovim/neovim/releases/download/$VERSION/nvim.appimage.sha256sum

    sha256sum -c nvim.appimage.sha256sum
    echo press ctrl-c to abort or return if the sum is okay
    read

    # todo if no fuse (lsmod fuse)
    # nvim.image --appimage-extract
    # squashfs-root/usr/bin/nvim

    chmod +x nvim.appimage
    ln -s ./nvim.appimage nvim
    popd > /dev/null
}

function install-fzf()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    VERSION="0.29.0"

    wget https://github.com/junegunn/fzf/releases/download/$VERSION/fzf-$VERSION-linux_amd64.tar.gz
    tar -xf ./fzf-$VERSION-linux_amd64.tar.gz
    rm ./fzf-$VERSION-linux_amd64.tar.gz

    popd > /dev/null
}

function install-rg()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    mkdir bash_compl.d
    mkdir doc

    VERSION="13.0.0"

    wget https://github.com/BurntSushi/ripgrep/releases/download/$VERSION/ripgrep-$VERSION-x86_64-unknown-linux-musl.tar.gz
    tar -xf ripgrep-$VERSION-x86_64-unknown-linux-musl.tar.gz
    rm ripgrep-$VERSION-x86_64-unknown-linux-musl.tar.gz

    pushd ripgrep-$VERSION-x86_64-unknown-linux-musl > /dev/null
    mv rg ..
    mv complete/rg.bash ../bash_compl.d
    mv doc/rg.1 ../doc/
    popd > /dev/null

    rm -rf ./ripgrep-$VERSION-x86_64-unknown-linux-musl

    popd > /dev/null
}

# setup the basic configs to point to the repos nvim config
function neovim-setup-configs()
{
    TARGET_INIT_VIM="$DB_SETTINGS_VIM_BASE"common.vim

    # make sure the config dir exists
    mkdir -p ~/.config/nvim

    pushd ~/.config/nvim > /dev/null
    echo "should be inside neovim config dir. Current dir is: "
    pwd

    # if init.vim is not a link
    if [[ ! -L init.vim ]]; then
        echo init.vim is not a link

        # check if init.vim exists (means it is a normal file)
        if [[ -f init.vim ]]; then
            echo backup init.vim to init.vim.bak
            cp init.vim init.vim.bak
            rm init.vim
        fi

        echo create symlink to "$TARGET_INIT_VIM"
        # create a symlink to the repos init.vim
        ln -s "$TARGET_INIT_VIM" init.vim
    else
        # symlink exists, verify it points to the correct file
        if [ ! "$(readlink -- init.vim)" = "$TARGET_INIT_VIM" ]; then
            echo update symlink of init.vim to "$TARGET_INIT_VIM"
            rm init.vim
            ln -s "$TARGET_INIT_VIM" init.vim
        fi
    fi

    popd > /dev/null
}

function neovim-install-dependencies()
{
    sudo apt install fzf ripgrep shellcheck
    # without root access (TODO)

    # python3 and pynvim
    sudo apt install python3 python3-pip
    pip3 install pynvim             # if not installed yet
    sudo pip3 install --upgrade pynvim   # upgrade if was already installed

    # nodejs latest
    curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install nodejs 
    sudo npm -g install neovim
}

