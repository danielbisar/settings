#!/bin/bash

clone-repo()
{
        pushd ~/src
        git clone https://github.com/danielbisar/settings.git
        popd
}

download-repo()
{
        pushd ~/src
        wget -O settings.tar.gz https://github.com/danielbisar/settings/tarball/main
        mkdir settings
        tar xvf settings.tar.gz --strip 1 -C settings
        rm settings.tar.gz
        popd
}


if [[ -d "~/src/settings" ]]
then
    echo found settings folder
else
    echo settings folder not found
    mkdir -p ~/src
    type -P git &>/dev/null && clone-repo || download-repo
fi
