#!/bin/bash

db-chars-sauce-code-pro-test()
{
    hex=({{0..9},{a..f}}{{0..9},{a..f}}{{0..9},{a..f}}{{0..9},{a..f}})

    for i in {57504..57507}; do
        echo -en "${hex[$i]} = \u${hex[$i]}  "
    done

    # powerline font symbols
    for i in {57520..57554}; do
        echo -en "${hex[$i]} = \u${hex[$i]}  "
    done

    i=57556
    echo -en "${hex[$i]} = \u${hex[$i]}  "

    for i in {57600..57681}; do
        echo -en "${hex[$i]} = \u${hex[$i]}  "
    done
}
