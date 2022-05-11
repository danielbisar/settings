#!/bin/bash

db-colors-reset()
{
    echo -en "\e[0m"
}

db-output-set-background-color()
{
    echo -en "\e[48;2;$1;$2;$3m"
}

db-colors-set-bg()
{
    color_seq=$(db-colors-hex-to-term "$1")
    echo -en "\e[48;2;$color_seq"
}

db-colors-set-fg()
{
    color_seq=$(db-colors-hex-to-term "$1")
    echo -en "\e[38;2;$color_seq"
}

db-colors-hex-to-term()
{
    # expect #RRGGBB
    # skip #
    HEX_COLOR="$(echo $1 | cut -b2-)"

    R=$(echo $HEX_COLOR | cut -b1-2)
    G=$(echo $HEX_COLOR | cut -b3-4)
    B=$(echo $HEX_COLOR | cut -b5-6)

    # convert to decimal
    R=$(echo "obase=10; ibase=16; $R" | bc)
    G=$(echo "obase=10; ibase=16; $G" | bc)
    B=$(echo "obase=10; ibase=16; $B" | bc)

    echo "$R;$G;$B"m
}

db-colors-test-256()
{
    columns=$(tput cols)
    length_per_color=5

    colors_per_line=$((columns / length_per_color))

    for color in {0..255}; do

        # for bright colors change foreground color to black, so you can still read the text
        if [[ $color == 7 || $color == 15 ||
            ($color -gt 37 && $color -lt 52) ||
            ($color -gt 70 && $color -lt 88) ||
            ($color -gt 95 && $color -lt 124) ||
            ($color -gt 132 && $color -lt 232) ||
            $color -gt 245 ]]; then
            echo -n -e "\e[30m"
        fi

        # Display the color
        printf "\e[48;5;%sm %3s " $color $color
        db-output-reset

        # new line after colors_per_line colors
        if [ $(((color + 1) % colors_per_line)) == 0 ]; then
            echo
        fi
    done
    echo
}

db-colors-test-24bit()
{
    for gray in $(seq 0 3 255); do
        db-output-set-background-color $gray $gray $gray
        echo -n ' '
    done
    db-output-reset
    echo

    for r in $(seq 0 3 255); do
        db-output-set-background-color $r 0 0
        echo -n ' '
    done
    db-output-reset
    echo

    for g in $(seq 0 3 255); do
        db-output-set-background-color 0 $g 0
        echo -n ' '
    done
    db-output-reset
    echo

    for b in $(seq 0 3 255); do
        db-output-set-background-color 0 0 $b
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color $m $m 0
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color $m $((m / 2)) 0
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color $m 0 $m
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color $((m / 2)) 0 $m
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color 0 $m $m
        echo -n ' '
    done
    db-output-reset
    echo

    for m in $(seq 0 3 255); do
        db-output-set-background-color 0 $((m / 2)) $m
        echo -n ' '
    done
    db-output-reset
    echo
}

db-color-tests()
{
    echo "test 256 color palette"
    db-colors-test-256

    echo "test 24 bit colors"
    db-colors-test-24bit
}
