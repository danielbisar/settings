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

Thats it. Now my custom settings will take effect.

