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
    fi

    # source environment
    . ~/.local/opt/db-settings/bash/environment.sh
}
