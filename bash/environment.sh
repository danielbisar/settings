#!/bin/bash
# this file is meant to be sourced to setup the whole environment
# variables and so forth as i like
LOCAL_SCRIPT_DIR="$(realpath "$(dirname "$BASH_SOURCE")")"
. "$LOCAL_SCRIPT_DIR/variables.sh"

. "$DB_SETTINGS_BASE"/bash/chars.sh
. "$DB_SETTINGS_BASE"/bash/colors.sh
. "$DB_SETTINGS_BASE"/bash/db.sh
. "$DB_SETTINGS_BASE"/bash/docker.sh
. "$DB_SETTINGS_BASE"/bash/fix_bash_history.sh
. "$DB_SETTINGS_BASE"/bash/install.sh
. "$DB_SETTINGS_BASE"/bash/prompt.sh
. "$DB_SETTINGS_BASE"/bash/preview.sh
. "$DB_SETTINGS_BASE"/bash/sys.sh

export EDITOR=nvim

# make fzf use ripgrep if installed
if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

# enable multi-select for FZF and use the preview function
#export FZF_DEFAULT_OPTS="-m --preview='preview {}' --ansi"

# required to clean up the left over image preview
#fzf()
#{
#  export orig_cols=$COLUMNS
#  export orig_rows=$LINES
#  "$DB_ROOT"fzf $@
#  # clean up left over images
#  tput smcup
#  kitty +kitten icat --clear
#  tput rmcup
#}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

export DOTNET_CLI_TELEMETRY_OPTOUT=1

##################### ALIASES
# cd git root
alias cdgr='cd $(git rev-parse --show-toplevel)'
alias gcm='git commit -m'
alias ga='git add'
alias gd='git diff'
alias gl='git log --oneline --decorate'
alias gs='git status'
alias gp='git push'
# think: git get
alias gg='git pull'
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -C'
alias n=nvim
alias edit-env='nvim "$DB_SETTINGS_BASE"/bash/environment.sh && . "$DB_SETTINGS_BASE"/bash/environment.sh'
alias edit-setup='nvim "$DB_SETTINGS_BASE"/bash/setup.sh'
alias wez-conf='nvim "$DB_SETTINGS_BASE"/config/wezterm/wezterm.lua'

db-reload-env()
{
  . "$DB_SETTINGS_BASE"/bash/environment.sh
}

#################### KEYBINDINGS
# PgUp and PgDown to search history
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

PATH="$PATH:$HOME/.db"

# -n = length is non_zero
if [ "$IS_WSL" == 1 ]; then
  . "$DB_SETTINGS_BASE/bash/"wsl.sh
  cd
fi

. "$DB_SETTINGS_BASE/bash/install.sh"

############### PROMPT
db-setup-prompt
