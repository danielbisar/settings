#!/bin/bash

db-bash-prompt-command()
{
    echo -en "\e[0m"

    COLUMNS=$(tput cols)
    # right aligned time
    printf "%${COLUMNS}s" "$(date +%H:%M:%S)"
    # move cursor back to the begining of the current line
    echo -en "\e[${COLUMNS}D"

    IS_GIT_REPO=0
    GIT_CLEAN=0
    GIT_BG_COLOR=42

    if git rev-parse 2>/dev/null; then
        IS_GIT_REPO=1

        if git diff --quiet; then
            GIT_CLEAN=1
        else
            GIT_BG_COLOR=43
        fi
    fi

    echo -en "\e[43m\e[30m${HOSTNAME}"
    echo -en "\e[42m\e[33m\uE0B8"

    echo -en "\e[42m\e[30m${USER}"
    echo -en "\e[44m\e[32m\uE0B8"

    echo -en "\e[44m\e[39m${PWD}"

    if [ $IS_GIT_REPO = 1 ]; then
        echo -en "\e[${GIT_BG_COLOR}m\e[34m\uE0B0"
    else
        echo -en "\e[49m\e[34m\uE0B0"
    fi

    # Additions for special folders
    folder=$(basename "$PWD")

    if [ "$folder" == "Downloads" ]; then
        echo -en " \uF6D9"
    elif [ "$folder" == "Pictures" ]; then
        # the icons lines are very thin so display it in bold
        echo -en " \e[1m\uF1C1"
    fi

    if [ $IS_GIT_REPO = 1 ]; then
        echo -en "\e[30m\e[${GIT_BG_COLOR}m \uE725 $(git branch --show-current) "
    fi

    echo -e "\e[0m"
}

db-setup-prompt()
{
    export PROMPT_COMMAND="db-bash-prompt-command"
    PS1="\$ "
}
