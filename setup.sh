#!/bin/bash

if [[ ! -d "~/src/settings" ]]
then
    echo found settings folder
else
    echo settings folder not found
    mkdir -p ~/src

fi
