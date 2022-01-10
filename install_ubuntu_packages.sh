#!/bin/bash
# rg command - most often faster and easier to use than grep
sudo apt install ripgrep

# fzf - the fuzzy file finder
sudo apt install fzf

function install_dotnet()
{
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt-get update; \
        sudo apt-get install -y apt-transport-https && \
        sudo apt-get update && \
        sudo apt-get install -y dotnet-sdk-6.0
}
