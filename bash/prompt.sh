#!/bin/bash

db-bash-prompt-command()
{
    "$DB_SETTINGS_BASE"/prompt/build/prompt
}

db-rebuild-prompt()
{
    sudo apt install -y libgit2-dev cmake g++
    pushd "$DB_SETTINGS_BASE"/prompt || return
    mkdir -p build
    cd build
    cmake ..
    make
    popd
}

db-setup-prompt()
{
    if [ ! -f "$DB_SETTINGS_BASE"/prompt/build/prompt ]; then
        db-rebuild-prompt
    fi

    export PROMPT_COMMAND="db-bash-prompt-command"
    PS1="\$ "
}
