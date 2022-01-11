# this file is meant to be sourced to setup environment
# variables and so forth as i like

# make fzf use ripgrep if installed 
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

# enable multi-select for FZF
export FZF_DEFAULT_OPTS='-m'

export DOTNET_CLI_TELEMETRY_OPTOUT=1

##################### ALIASES
alias gcm='git commit -m' 
alias ga='git add'
alias gs='git status'
alias n=nvim
alias edit-env='nvim ~/src/settings/environment.sh && . ~/src/settings/environment.sh'
alias edit-setup='nvim ~/src/settings/setup.sh'

setup-env()
{
    ~/src/settings/setup.sh
}

#### helpful functions ######
color_test_256()
{
    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            # Display the color
            printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
            # Display 6 colors per lines
            if [ $((($color + 1) % 6)) == 4 ] ; then
                echo # New line
            fi
        done
        echo # New line
    done
}

setBackgroundColor()
{
    #printf '\x1bPtmux;\x1b\x1b[48;2;%s;%s;%sm' $1 $2 $3
    printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}

resetOutput()
{
    echo -en "\x1b[0m\n"
}

# Gives a color $1/255 % along HSV
# Who knows what happens when $1 is outside 0-255
# Echoes "$red $green $blue" where
# $red $green and $blue are integers
# ranging between 0 and 255 inclusive
rainbowColor()
{ 
    let h=$1/43
    let f=$1-43*$h
    let t=$f*255/43
    let q=255-t

    if [ $h -eq 0 ]
    then
        echo "255 $t 0"
    elif [ $h -eq 1 ]
    then
        echo "$q 255 0"
    elif [ $h -eq 2 ]
    then
        echo "0 255 $t"
    elif [ $h -eq 3 ]
    then
        echo "0 $q 255"
    elif [ $h -eq 4 ]
    then
        echo "$t 0 255"
    elif [ $h -eq 5 ]
    then
        echo "255 0 $q"
    else
        # execution should never reach here
        echo "0 0 0"
    fi
}


color_test_24bit()
{
    for i in `seq 0 127`; do
        setBackgroundColor $i 0 0
        echo -en " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor $i 0 0
        echo -en " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor 0 $i 0
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor 0 $i 0
        echo -n " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor 0 0 $i
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor 0 0 $i
        echo -n " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor `rainbowColor $i`
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor `rainbowColor $i`
        echo -n " "
    done
    resetOutput
}


