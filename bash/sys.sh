#!/bin/bash

fwhich()
{
    # if the given arg is a function
    if declare -F "$1" &> /dev/null; then
        shopt -s extdebug
        # with extdebug enabled this will print the source location where the function is defined
        declare -F "$1"
        shopt -u extdebug
    else
        echo "$1 is not a function."
    fi
}

sys-update()
{
    sudo apt update
    sudo apt upgrade
}

sys-file-provided-by()
{
    dkpg -S "$1"
}
