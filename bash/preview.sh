#!/bin/bash

preview()
{
    fileName="$1"

    # default behavior
    echo "source ~/.config/nvim/init.vim | :exe \"edit \" . fnameescape('$fileName') | call AnsiHighlight('/tmp/ccat.tmp') | q" | nvim -es -R
    cat /tmp/ccat.tmp
}

# export the method so we can use it fzf --preview
export -f preview
