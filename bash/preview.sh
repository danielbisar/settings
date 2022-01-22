#!/bin/bash

#HAS_KITTY=$(type kitty &> /dev/null && echo 1 || echo 0)
#if [[ 1 -eq 1 ]] ; then echo x; else echo z; fi

# todo check if executed from kitty 
# xterm-kitty in $TERM


preview()
{
    fileName="$1"

    if file "$fileName" | grep image &> /dev/null; then
        # tput cols just gets the partial area of the fzf preview window, not 
        # the total terminal width; this is why the function defined in 
        # environment.sh exports orig_cols and orig_rows
        rows=$(tput lines)

        let columns=orig_cols/2
        let columns=columns-4
        let x=orig_cols/2+4
        let y=2

        # allows debugging of position values
        #echo $columns X $rows @ $x X $y
        kitty +kitten icat --clear --transfer-mode stream --place=${columns}x${rows}@${x}x${y} --silent "$fileName"
    else
        kitty +kitten icat --transfer-mode stream --clear
        # default behavior
        echo "source ~/.config/nvim/init.vim | :exe \"edit \" . fnameescape('$fileName') | call AnsiHighlight('/tmp/ccat.tmp') | q" | nvim -es -R
        cat /tmp/ccat.tmp
    fi
}

# export the method so we can use it fzf --preview
export -f preview

