#!/bin/bash

# DB_INSTALL_LOCATION is the only variable that is set directly inside .bashrc
export DB_ROOT="$DB_INSTALL_LOCATION"
export DB_SETTINGS_BASE="$(realpath "$(dirname "$BASH_SOURCE")"/../)"
export DB_SETTINGS_VIM_BASE="$DB_SETTINGS_BASE/vim/"
export DB_SETTINGS_BASH_BASE="$DB_SETTINGS_BASE/bash/"

export DB_USE_HTTPS_FOR_PULL=1
