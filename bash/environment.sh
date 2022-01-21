# this file is meant to be sourced to setup environment
# variables and so forth as i like

export SETTINGS_BASE="$(dirname "${BASH_SOURCE[0]}")"
export SETTINGS_VIM_BASE="$(dirname "${BASH_SOURCE[0]}")/../vim"

# make fzf use ripgrep if installed 
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

# enable multi-select for FZF
export FZF_DEFAULT_OPTS='-m'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




export DOTNET_CLI_TELEMETRY_OPTOUT=1

##################### ALIASES
alias gcm='git commit -m' 
alias ga='git add'
alias gd='git diff'
alias gl='git log --oneline --decorate'
alias gs='git status'
alias gp='git push'
alias n=nvim
alias edit-env='nvim $SETTINGS_BASE/environment.sh && . $SETTINGS_BASE/environment.sh'
alias edit-setup='nvim $SETTINGS_BASE/setup.sh'
alias image-show='kitty +kitten icat'

#################### KEYBINDINGS
# PgUp and PgDown to search history
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

. "$SETTINGS_BASE"/colors.sh


