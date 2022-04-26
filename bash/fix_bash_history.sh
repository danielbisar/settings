#!/bin/bash
# history setup
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# how much lines to remember in the running session
HISTSIZE=10000
# how much lines to save in the hist file
HISTFILESIZE=10000

# change behavior of bash history
# normal behavior: bash overwrites the history -> last terminal wins
# this script: merge history of all session on close

# original source from: https://askubuntu.com/questions/80371/bash-history-handling-with-multiple-terminals
[[ -d /tmp/history ]] || mkdir --mode=0700 /tmp/history

export DB_ORIGINAL_HISTFILE="$HISTFILE"
HIST_FILE_NAME=/tmp/history/$(date +%Y_%m_%d_%H_%M_%S).$$


# 'copy' history; but elimate duplicates (just the ones that follow up on each other); this is to clean up
# history files that were used otherwise before
cat "$HISTFILE" | uniq > "$HIST_FILE_NAME"
export DB_ORIGINAL_HISTFILE_LINES=$(cat "$HIST_FILE_NAME" | wc -l)

# update HISTFILE path
HISTFILE="$HIST_FILE_NAME"

function db-hist-on-close()
{
    echo exit hook > ~/exit.log

    # force write out of current history
    history -a

    LINES_TO_SKIP=$((DB_ORIGINAL_HISTFILE_LINES + 1))

    # append the new lines to the original hist file
    # note: -n +NUM skips the first NUM lines
    tail -n +$LINES_TO_SKIP "$HISTFILE" | uniq >> "$DB_ORIGINAL_HISTFILE"


    #echo "HISTFILE: $DB_ORIGINAL_HISTFILE" >> ~/exit.log
    #echo "ORIG LENGTH: $DB_ORIGINAL_HISTFILE_LINES" >> ~/exit.log
    #echo "tail -n +$LINES_TO_SKIP \"$HISTFILE\" | uniq" >> ~/exit.log
    #tail -n +$LINES_TO_SKIP "$HISTFILE" | uniq >> ~/exit.log
}

trap db-hist-on-close EXIT
