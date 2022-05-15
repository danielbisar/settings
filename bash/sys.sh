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

sys-stat-net-usage()
{
    # list network devices: ls -1 /sys/class/net/
    local device="$1"
    local duration=10

    echo "sampling $duration seconds..."

    orig_rx_bytes=$(cat /sys/class/net/$device/statistics/rx_bytes)
    orig_tx_bytes=$(cat /sys/class/net/$device/statistics/tx_bytes)

    sleep $duration

    rx_bytes=$(cat /sys/class/net/$device/statistics/rx_bytes)
    tx_bytes=$(cat /sys/class/net/$device/statistics/tx_bytes)

    # 131072 = (1024*1024)/8 = mbit

    rx_mbit_per_second=$(echo "scale=2; (($rx_bytes - $orig_rx_bytes) / $duration.0) / 131072.0" | bc -q)
    tx_mbit_per_second=$(echo "scale=2; (($tx_bytes - $orig_tx_bytes) / $duration.0) / 131072.0" | bc -q)

    echo recv: $rxb_per_second Mbit/s
    echo send: $txb_per_second Mbit/s
}


db-get-cmp-ratio()
{
    python3 "$DB_SETTINGS_BASE"/python/fs.py
}

