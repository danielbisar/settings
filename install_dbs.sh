#!/bin/bash
# goal: copy and paste this into your .bashrc and you are ready to go, no need to download anything beforehand
db-settings-setup()
{
    # not installed
    if [ ! -f ~/.local/opt/db-settings/bash/environment.sh ]; then
        mkdir -p ~/.local/opt
        cd ~/.local/opt

        # just expect git to be present!

        # verify we can use ssh connections; to support scenarios behind VPN that don't allow ssh... (why????)
        if timeout 5 bash -c "</dev/tcp/github.com/22"; then
            echo "Using ssh to clone"
            git clone git@github.com:danielbisar/settings.git db-settings
        else
            echo "Using https to clone"
            git clone https://github.com/danielbisar/settings.git db-settings
        fi

        # set the default origin to ssh so we always have both
        # origin = ssh, origin-https = https ;)
        cd db-settings
        git remote set-url origin git@github.com:danielbisar/settings.git
        git remote add origin-https https://github.com/danielbisar/settings.git
        cd -
    else
        # pull one time a day
        DB_UPDATED_TODAY_FILE_NAME="/tmp/DB_$(date +%Y_%m_%d)"

        if [ ! -f "$DB_UPDATED_TODAY_FILE_NAME" ]; then
            # check for updates
            cd ~/.local/opt/db-settings
            git pull origin-https main && touch "$DB_UPDATED_TODAY_FILE_NAME"
            cd -
        fi
    fi

    # source environment
    . ~/.local/opt/db-settings/bash/environment.sh
}

db-settings-uninstall()
{
    cd ~/.local/opt/
    rm -rf db-settings
    cd -

    # restore some default prompt for this session
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'

    echo "to prevent reinstallation remove db-settings-setup() from your ~/.bashrc and restart your terminal session"
}
