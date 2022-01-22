#!/bin/bash

preview()
{
    fileName="$1"

    if file "$fileName" | grep image &> /dev/null; then
        kitty +kitten icat --clear --transfer-mode stream --align=right --place=50x50@100x3 --silent "$fileName"
    else
        kitty +kitten icat --clear --transfer-mode stream --silent
        # default behavior
        echo "source ~/.config/nvim/init.vim | :exe \"edit \" . fnameescape('$fileName') | call AnsiHighlight('/tmp/ccat.tmp') | q" | nvim -es -R
        cat /tmp/ccat.tmp
    fi
}

# export the method so we can use it fzf --preview
export -f preview
