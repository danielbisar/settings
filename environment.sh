# this file is meant to be sourced to setup environment
# variables and so forth as i like

# make fzf use ripgrep if installed 
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

# enable multi-select for FZF
export FZF_DEFAULT_OPTS='-m'

