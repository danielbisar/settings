#!/bin/bash

if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then 
    export IS_WSL=1
else 
    export IS_WSL=0
fi

wsl-restore-resolv-conf()
{
    if [ -L /etc/resolv.conf ]; then 
        echo resolv.conf is already a link
    else
        sudo chattr -i /etc/resolv.conf
        sudo rm /etc/resolv.conf
        sudo rm /etc/wsl.conf
    fi
}

wsl-prevent-auto-resolv-conf()
{
    if [ -L /etc/resolv.conf ]; then 
        echo resolv.conf is a link
        sudo rm /etc/resolv.conf
        sudo bash -c 'echo "[network]
generateResolv.conf = false" > /etc/wsl.conf'
        sudo bash -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'
        sudo chattr +i /etc/resolv.conf
    else
        echo resolv.conf is already a custom file
    fi
}
