#!/bin/bash
# script to install this repo
# usage:
#
# bash -c "$(wget -O - https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"
# OR
# bash -c "$(curl https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"

INSTALL_LOCATION=~/.db

if [ ! -z "$1" ]; then
    INSTALL_LOCATION="$1"
fi

db-clone-repo()
{
    echo "Cloning repository..."

    pushd "$INSTALL_LOCATION" > /dev/null || return
    git clone https://github.com/danielbisar/settings.git
    popd > /dev/null
}

db-download-repo()
{
    echo "Downloading repository..."

    pushd "$INSTALL_LOCATION" > /dev/null || return

    if type -P wget &> /dev/null; then
        wget -O settings.tar.gz https://github.com/danielbisar/settings/tarball/main
    else
        curl -o settings.tar.gz https://github.com/danielbisar/settings/tarball/main
    fi

    mkdir settings
    tar xvf settings.tar.gz --strip 1 -C settings
    rm settings.tar.gz

    popd > /dev/null
}


if [ -d "$INSTALL_LOCATION/settings" ]; then
    echo "$INSTALL_LOCATION/settings already exists. Do nothing."
else
    mkdir -p "$INSTALL_LOCATION" || return
    type -P git &> /dev/null && db-clone-repo || db-download-repo

    echo "" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "export DB_INSTALL_LOCATION=\"$INSTALL_LOCATION\"" >> ~/.bashrc
    echo '. "$DB_INSTALL_LOCATION/settings/bash/environment.sh"' >> ~/.bashrc
    . ~/.bashrc
fi
