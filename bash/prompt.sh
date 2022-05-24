#!/bin/bash

db-bash-prompt-command()
{
    # "$DB_SETTINGS_BASE"/cs/bin/Release/net6.0/linux-x64/publish/cs
    "$DB_SETTINGS_BASE"/prompt/build/prompt
    #     COLUMNS=$(tput cols)
    #     DATE_START_COL=$((COLUMNS - 9))
    #     CUR_TIME="$(date +%H:%M:%S)"
    #
    #     IS_GIT_REPO=0
    #     GIT_CLEAN=0
    #     GIT_BG_COLOR=42
    #
    #     if git rev-parse 2>/dev/null; then
    #         IS_GIT_REPO=1
    #
    #         if git diff --quiet; then
    #             GIT_CLEAN=1
    #         else
    #             GIT_BG_COLOR=43
    #         fi
    #     fi
    #
    #     CWD="$PWD"
    #
    #     # replace $HOME with ~
    #     [[ "$CWD" =~ ^"$HOME"(/|$) ]] && CWD="~${CWD#$HOME}"
    #
    #     db-colors-reset
    #     # right aligned time
    #     echo -en "\e[${DATE_START_COL}C"
    #
    #     db-colors-reset && db-colors-set-fg '#2075C7' && echo -en '\uE0B6'
    #     db-colors-reset && db-colors-set-bg '#2075C7' && echo -n "$CUR_TIME"
    #     db-colors-reset
    #
    #     # move cursor back to the begining of the current line
    #     echo -en "\e[${COLUMNS}D"
    #
    #     db-colors-set-bg '#B68800' && db-colors-set-fg '#000000' && echo -n "$HOSTNAME"
    #     db-colors-set-bg '#629655' && db-colors-set-fg '#B68800' && echo -en '\uE0B8'
    #     db-colors-set-bg '#629655' && db-colors-set-fg '#000000' && echo -n "$USER"
    #     db-colors-set-bg '#2075C7' && db-colors-set-fg '#629655' && echo -en '\uE0B8'
    #     db-colors-set-bg '#2075C7' && db-colors-set-fg '#000000' && echo -n "$CWD"
    #
    #     if [ -L "$PWD" ]; then
    #         LINK_TARGET="$(readlink "$PWD")"
    #         # replace $HOME with ~
    #         [[ "$LINK_TARGET" =~ ^"$HOME"(/|$) ]] && LINK_TARGET="~${LINK_TARGET#$HOME}"
    #
    #         # if current dir is symlink, display the target
    #         echo -en " \uF178 ${LINK_TARGET}"
    #     fi
    #
    #     if [ $IS_GIT_REPO = 1 ]; then
    #         echo -en "\e[${GIT_BG_COLOR}m\e[34m\uE0B0"
    #     else
    #         db-colors-reset && db-colors-set-fg '#2075C7' && echo -en "\uE0B0"
    #     fi
    #
    #     # Additions for special folders
    #     folder=$(basename "$PWD")
    #
    #     if [ "$folder" == "Downloads" ]; then
    #         echo -en " \uF6D9"
    #     elif [ "$folder" == "Pictures" ]; then
    #         # the icons lines are very thin so display it in bold
    #         echo -en " \e[1m\uF1C1"
    #     fi
    #
    #     if [ $IS_GIT_REPO = 1 ]; then
    #         echo -en "\e[30m\e[${GIT_BG_COLOR}m \uE725 $(git branch --show-current) "
    #     fi
    #
    #     echo -e "\e[0m"
}

db-rebuild-prompt()
{
    sudo apt install -y libgit2-dev
    pushd "$DB_SETTINGS_BASE"/prompt || return
    mkdir -p build
    pushd build || return
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
