#!/bin/bash

sys-update()
{
    sudo apt update
    sudo apt upgrade
}

sys-file-provided-by()
{
    dkpg -S "$1"
}

