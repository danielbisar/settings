#!/bin/bash
# script to install this repo
# usage:
# bash -c "$(wget -O - https://raw.githubusercontent.com/danielbisar/settings/main/db_install.sh)"

clone-repo()
{
    pushd ~/.db
    git clone https://github.com/danielbisar/settings.git
    popd
}

download-repo()
{
    pushd ~/.db
    wget -O settings.tar.gz https://github.com/danielbisar/settings/tarball/main
    mkdir settings
    tar xvf settings.tar.gz --strip 1 -C settings
    rm settings.tar.gz
    popd
}


if [[ -d "~/.db/settings" ]]
then
    echo "found ~/.db/settings folder"
else
    echo "download and install..."
    mkdir -p ~/.db
    type -P git &> /dev/null && clone-repo || download-repo
fi
