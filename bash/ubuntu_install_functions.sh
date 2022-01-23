#!/bin/bash

install-basic-tools()
{
    # good to to after a fresh installation
    sudo apt update
    sudo apt upgrade

    sudo apt install fzf ripgrep ppa-purge neovim

    # python3 and pynvim
    sudo apt install python3 python3-pip
    pip3 install pynvim             # if not installed yet
    sudo pip3 install --upgrade pynvim   # upgrade if was already installed

    # nodejs latest
    curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install nodejs 
    sudo npm -g install neovim
}

install-basic-graphics-programs()
{
    sudo apt install mesa-utils
}

install-dotnet()
{
    ubunturelease=$(grep VERSION_ID /etc/os-release)
    ureleaseversion=${ubunturelease:12:-1}

    wget https://packages.microsoft.com/config/ubuntu/$ureleaseversion/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt-get update; \
        sudo apt-get install -y apt-transport-https && \
        sudo apt-get update && \
        sudo apt-get install -y dotnet-sdk-6.0
}


# fonts
install-source-code-pro()
{
    mkdir -p ~/.fonts
    pushd ~/.fonts

    wget https://github.com/adobe-fonts/source-code-pro/releases/download/1.017R/source-code-pro-1.017R.zip
    unzip source-code-pro-1.017R.zip
    rm LICENSE.md
    rm source-code-pro-1.017R.zip

    popd
    fc-cache -f -v
}

install-kitty-and-dependencies()
{
    sudo apt install fontconfig
    install-source-code-pro
    sudo apt install kitty imagemagick
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

