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

export DOTNET_CLI_TELEMETRY_OPTOUT=1

##################### ALIASES
alias gcm='git commit -m' 
alias ga='git add'
alias gl='git log --oneline --decorate'
alias gs='git status'
alias n=nvim
alias edit-env='nvim $SETTINGS_BASE/environment.sh && . $SETTINGS_BASE/environment.sh'
alias edit-setup='nvim $SETTINGS_BASE/setup.sh'

#################### KEYBINDINGS
# PgUp and PgDown to search history
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

. "$SETTINGS_BASE"/colors.sh


