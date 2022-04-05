# script to fix behavior of bash history
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

function on_close()
{
    # append the new lines to histfile
    # note: -n +NUM skips the first NUM lines
    tail -n +$DB_ORIGINAL_HISTFILE_LINES "$HISTFILE" >> "$DB_ORIGINAL_HISTFILE"
}

trap on_close EXIT
