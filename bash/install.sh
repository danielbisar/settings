#!/bin/bash

function db-download()
{
    wget -nv --show-progress $@
}

# TODO check if a package is already available before installing

function db-install-neovim()
{
    mkdir -p "$DB_ROOT"
    pushd "$DB_ROOT" > /dev/null

    db-download https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

    chmod u+x nvim.appimage

    # make sure the link is deleted before creating a new one, if it already exist
    rm ./nvim

    # check for fuse support
    if ! type fusermount &> /dev/null; then
        ./nvim.appimage --appimage-extract
        ln -s ./squashfs-root/usr/bin/nvim nvim
        rm ./nvim.appimage
    else
        ln -s ./nvim.appimage nvim
    fi

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

function db-install-nodejs()
{
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
}


function db-install-fd()
{
    sudo apt install fd-find
}

# setup the basic configs to point to the repos nvim config
function db-neovim-setup-configs()
{
    # make sure the config dir exists
    if [[ ! -d ~/.config ]]; then
        mkdir ~/.config
        echo created .config folder
    fi

    pushd ~/.config || return

    if [[ -d ./nvim ]]; then
        echo 'nvim is a directory, create backup'
        mv nvim nvim.bak
    elif [[ -L ./nvim ]]; then
        echo 'nvim is already a link, delete that link'
        rm ./nvim
    fi

    echo create new link with ln -s ./nvim/ "$DB_SETTINGS_BASE"/neovim/
    ln -s "$DB_SETTINGS_BASE"/neovim/ ./nvim

    echo "done"
    popd
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

function db-install-wezterm()
{
    OS_ID=$(cat /etc/os-release | grep ^ID= | cut -d= -f 2)

    if [ ! "$OS_ID" = "ubuntu" ]; then
        echo not an ubuntu system
        return
    fi

    VERSION_ID=$(cat /etc/os-release | grep VERSION_ID | cut -d"=" -f 2)

    DOWNLOAD_URL=""

    if [ "$VERSION_ID" = "\"20.04\"" ]; then
	DOWNLOAD_URL="https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu20.04.deb"
    elif [ "$VERSION_ID" = "\"22.04\"" ]; then
	DOWNLOAD_URL="https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb"
    fi

    if [ -z "$DOWNLOAD_URL" ]; then
	echo "don't know download url for this type of os"
	return
    fi

    # in case of wezterm, the nighly is used by the developer
    # and he advices to use that version, should be kind of stable
    rm /tmp/wezterm-nightly.deb
    db-download -O /tmp/wezterm-nightly.deb "$DOWNLOAD_URL"
    sudo apt install /tmp/wezterm-nightly.deb
    rm /tmp/wezterm-nightly.deb
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

    export CC=/usr/bin/clang-14
    export CXX=/usr/bin/clang++-14

    export CXXFLAGS=-O3 -march=native
    export CCFLAGS=-O3 -march=native

    make CMAKE_BUILD_TYPE=Release
    sudo make install
}

install-basic-graphics-programs()
{
    sudo apt install mesa-utils
}

db-install-dotnet()
{
    ubunturelease=$(grep VERSION_ID /etc/os-release)
    ureleaseversion=${ubunturelease:12:-1}

    pushd /tmp

    wget https://packages.microsoft.com/config/ubuntu/$ureleaseversion/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    popd

    sudo apt-get update; \
        sudo apt-get install -y apt-transport-https && \
        sudo apt-get update && \
        sudo apt-get install -y dotnet-sdk-6.0
}


# fonts
db-install-sauce-code-pro()
{
    sudo mkdir -p /usr/share/fonts/opentype

    sudo wget -O /usr/share/fonts/opentype/scp-regular-mono.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf
    sudo wget -O /usr/share/fonts/opentype/scp-regular.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf

    sudo fc-cache -f -v
}

# MESA
install-latest-mesa()
{
    sudo add-apt-repository ppa:oibaf/graphics-drivers
    sudo apt update
    sudo apt upgrade
}

install-kiask-mesa()
{
    sudo add-apt-repository ppa:kisak/kisak-mesa
    sudo apt update
    sudo apt upgrade
}

remove-oibaf-ppa()
{
    sudo ppa-purge ppa:oibaf/graphics-driver
}

remove-kiask-ppa()
{
    sudo ppa-purge ppa:kisak/kisak-mesa
}

db-install-prompt-dependencies()
{
    sudo apt install libgit2-dev cmake
}

db-install-rust()
{
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

# installs default progams for ubuntu using apt
db-install-ubuntu-defaults()
{
    sudo apt-get update
    sudo apt-get upgrade -y

    sudo apt-get install neovim ctags vim-scripts vim-doc fzf ripgrep ppa-purge shellcheck

    db-install-rust

#     # neovim dependencies
#     # python3 and pynvim
#     sudo apt install python3 python3-pip
#     pip3 install pynvim             # if not installed yet
#     sudo pip3 install --upgrade pynvim   # upgrade if was already installed
#
#     # nodejs latest
#     curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
#     sudo apt install nodejs
#     sudo npm -g install neovim
}
