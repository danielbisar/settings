#!/bin/bash
# configuration specific to lfm

lfm()
{
    /usr/bin/lfm "$@"              # type here full path to lfm script
    LFMPATHFILE=/tmp/lfm-$$.path
    cd "`cat $LFMPATHFILE`" && rm -f $LFMPATHFILE
}

