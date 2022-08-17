#!/bin/bash

# To run this script on Gnome login create the file ~/.config/autostart/autostart.desktop with the following content:
# [Desktop Entry]
# Type=Application
# Name=AutostartScripts
# Exec=/bin/bash /home/dexxdb15/.local/opt/db-settings/bash/autostart.sh
# Hidden=false
# NoDisplay=false
# Terminal=true
# X-GNOME-Autostart-enabled=true
# Comment=Autostart shell scripts

# to add a delay also add a line like (or add it to teams.desktop file)
# X-GNOME-Autostart-Delay=10

#### Autoconnect bluetooth devices ####
# add one line per device with the mac address of the device to
# ~/.config/db-settings/autoconnect-bluetooth-devices
# get mac address with: bluetoothctl

if [ -f ~/.config/db-settings/autoconnect-bluetooth-devices ]; then
    for device in $(cat ~/.config/db-settings/autoconnect-bluetooth-devices); do
        echo "Connect Bluetooth Device $device"
        bluetoothctl connect $device
    done
fi

#### Set default audio devices ####

# use output of
# pacmd list-sinks
# and
# pacmd list-sources
# to identify available sinks and sources
#
# create a config file (~/.config/db-settings/default-audio-devices) with the following content
# out=sink_name
# in=source_name
if [ -f ~/.config/db-settings/default-audio-devices ]; then
    out_device=$(grep "^out=" ~/.config/db-settings/default-audio-devices)
    out_device=${out_device#out=}

    if [ -n "$out_device" ]; then
        echo "Set default output device to $out_device"
        pacmd set-default-sink "$out_device"
    fi

    in_device=$(grep "^in=" ~/.config/db-settings/default-audio-devices)
    in_device=${in_device#in=}

    if [ -n "$in_device" ]; then
        echo "Set default input device to $in_device"
        pacmd set-default-source "$in_device"
    fi
fi

#### run custom autostart.sh ####
if [ -f ~/.config/db-settings/autostart.sh ]; then
    echo "Run custom autostart.sh"
    /bin/bash ~/.config/db-settings/autostart.sh
fi
