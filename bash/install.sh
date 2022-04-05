#!/bin/bash

. "$(realpath $(dirname "$BASH_SOURCE"))/vars.sh"

function db-download()
{
    wget -nv --show-progress $@
}

# TODO check if a package is already available before installing

function install-neovim()
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

    rm nvim.appimage.sha256sum

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

function install-shellcheck()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    VERSION="v0.8.0"

    wget https://github.com/koalaman/shellcheck/releases/download/$VERSION/shellcheck-$VERSION.linux.x86_64.tar.xz
    tar -xf ./shellcheck-$VERSION.linux.x86_64.tar.xz
    rm ./shellcheck-$VERSION.linux.x86_64.tar.xz
    
    pushd ./shellcheck-$VERSION > /dev/null
    mv shellcheck ..
    popd > /dev/null

    rm -rf ./shellcheck-$VERSION

    popd > /dev/null
}

function install-nodejs()
{
    # mkdir -p "$DB_ROOT"
    # pushd "$DB_ROOT" > /dev/null

    # VERSION="v17.8.0"
    # wget "https://nodejs.org/dist/$VERSION/node-$VERSION-linux-x64.tar.xz"

    # sudo mkdir -p /usr/local/lib/nodejs
    # sudo tar -xJvf "node-$VERSION-linux-x64.tar.xz" -C /usr/local/lib/nodejs

    # rm "node-$VERSION-linux-x64.tar.xz"

    # echo 'export PATH=/usr/local/lib/nodejs/node-v17.6.0/bin:$PATH'
    
    # popd

    curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
    sudo apt install -y nodejs
}


function install-fd()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    VERSION="v8.3.2"

    wget "https://github.com/sharkdp/fd/releases/download/$VERSION/fd-$VERSION-x86_64-unknown-linux-gnu.tar.gz"
    tar -xf "fd-$VERSION-x86_64-unknown-linux-gnu.tar.gz"
    rm "fd-$VERSION-x86_64-unknown-linux-gnu.tar.gz"
    
    cd "fd-$VERSION-x86_64-unknown-linux-gnu"
    mv fd ..
    mv fd.1 ..

    mkdir -p ../bash_compl.d/
    mv autocomplete/fd.bash ../bash_compl.d/
    cd ..
    rm -rf "fd-$VERSION-x86_64-unknown-linux-gnu"

    popd
}

# setup the basic configs to point to the repos nvim config
function neovim-setup-configs()
{
    # TODO UPDATE --> ln -s ./nvim/ /home/debian/.db/settings/neovim/

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
    install-fzf
    install-rg
    install-shellcheck
    install-fd

    # TODO install the following without root access
    # python3 and pynvim
    sudo apt install python3 python3-pip
    pip3 install pynvim             # if not installed yet
    sudo pip3 install --upgrade pynvim   # upgrade if was already installed

    # nodejs latest
    curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install nodejs 
    sudo npm -g install neovim
}

function install-wezterm()
{
    OS_ID=$(cat /etc/os-release | grep ^ID= | cut -d= -f 2)

    if [ ! "$OS_ID" = "ubuntu" ]; then
        echo not an ubuntu system
        return
    fi

    VERSION_ID=$(cat /etc/os-release | grep VERSION_ID | cut -d"=" -f 2)

    if [ ! "$VERSION_ID" = "\"20.04\"" ]; then
        echo not ubuntu 20.04
        return
    fi

    # in case of wezterm, the nighly is used by the developer
    # and he advices to use that version, should be kind of stable
    rm /tmp/wezterm-nightly.Ubuntu20.04.deb
    db-download -O /tmp/wezterm-nightly.Ubuntu20.04.deb https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu20.04.deb
    sudo apt install /tmp/wezterm-nightly.Ubuntu20.04.deb
    rm /tmp/wezterm-nightly.Ubuntu20.04.deb

    popd
}

function install-clang-current()
{
	sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
}

function install-neovim-from-source()
{
	install-clang-current
    
    # https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites
	sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    
    # https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
    cd /tmp

    #https://github.com/neovim/neovim.git
    #git@github.com:neovim/neovim.git
    git clone git@github.com:neovim/neovim.git
    cd neovim
    git checkout release-0.6
    
    make CMAKE_BUILD_TYPE=Release
    sudo make install
}

