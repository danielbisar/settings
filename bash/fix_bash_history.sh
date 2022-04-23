
# history setup
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000



# change behavior of bash history
# normal behavior: bash overwrites the history -> last terminal wins
# this script: merge history of all session on close

# original source from: https://askubuntu.com/questions/80371/bash-history-handling-with-multiple-terminals
[[ -d /tmp/history ]] || mkdir --mode=0700 /tmp/history

export DB_ORIGINAL_HISTFILE="$HISTFILE"
export DB_ORIGINAL_HISTFILE_LINES=$(wc -l "$HISTFILE" | cut -d' ' -f1)
HIST_FILE_NAME=/tmp/history/$(date +%Y_%m_%d_%H_%M_%S).$$

# copy original file, so that after changing HISTFILE, we still have the old commands
cp "$HISTFILE" "$HIST_FILE_NAME"

# update HISTFILE path
HISTFILE="$HIST_FILE_NAME"

function db-hist-on-close()
{
    # append the new lines to histfile
    # note: -n +NUM skips the first NUM lines
    tail -n +$DB_ORIGINAL_HISTFILE_LINES "$HISTFILE" >> "$DB_ORIGINAL_HISTFILE"
}

trap db-hist-on-close EXIT
