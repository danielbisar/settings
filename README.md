# Repo for all the settings

My personal bash/nvim setup.

# LICENSE

If not stated otherwise (for example in a files header) the content is under the MIT license.
See LICENSE

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
bash -c "$(wget -O - https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"
# OR
bash -c "$(curl https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"
```

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

## nvim

After starting nvim for the first time after the setup execute :PlugInstall to install all required
plugins and the color scheme.

Restart vim.

Note: ; is mapped to : and : to ; for normal mode

- :Settings to quickly edit the common.vim
- :SettingsKeyboard to quickly edit the keymap
- :SettingsFiletypes for filetypes
- :SettingsNetrw for netrw configs
- :CleanAllCarriageReturns to remove all \r chars from the file
- theme = a bit like visual studio code

# IMPORTANT / credit

This repository contains source code from third parties found in public repositories.
See file headers for orignal authors/license of these files.

- ./vim/AnsiHighlight: Author: Matthew Wozniski 
- ./vim/autoload/vis.vim and ./vim/doc/vis.txt: Authors: Charles E. Campbell, based on idea of Stefan Roemer
- ./vim/autoload/plug.vim: Author: Junegunn Choi

If I missed to mention somone please contact me. All other files/code fall under the MIT License.
See LICENSE file.

