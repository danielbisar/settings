# Repo for all the settings

My personal bash/nvim setup.

# Download

You can use the scripts by just doing a git clone or use the setup.sh
which tries to will use git clone if available or wget to download the repo.

Currently the target folder is hard coded to be ~/src/settings

```
wget https://raw.githubusercontent.com/danielbisar/settings/main/bash/setup.sh
bash ./setup.sh
```
# Setup

To make the scripts take effect:

```
cd ~
bash ~/src/settings/bash/setup.sh
```

ATTENTION: This will replace your .vimrc and .config/nvim/init.vim even though 
it should backup the files beforehand. The .bashrc gets modified to contain 
~/src/settings/bash/environment.sh as last line.

## Further setup

To install dependencies (fzf, ripgrep, nodejs for coc.vim) on Ubuntu use the
bash/ubuntu_install_functions.sh script.

```
. ~/src/settings/bash/ubuntu_install_functions.sh
install-basic-tools
```

Now it is a good idea to log out and login again or source the environment.sh manually.

# What is included

## bash

- color_test_256 and color_test_24bit which output some test patterns to test your terminals color capabilities 
- fzf configured to use ripgrep
- bigger history
- color output enabled for grep, fgrep, egrep
- aliases ll, la, l (see environment.sh for what they do); for git: gcm, ga, gd, gl, gs, gp
    - n = nvim; 
    - edit-env = open environment.sh in nvim and source the file after closing
    - edit-setup = edit the setup.sh
- PgUp and PgDown mapped to search the history
