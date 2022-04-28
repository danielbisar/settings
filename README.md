# Repo for all the settings

My personal bash/nvim setup.

# LICENSE

If not stated otherwise (for example in a files header) the content is under the MIT license.
See LICENSE

# Download/Install

Default installation location ~/.db/settings.
The install_dbs.sh will clone the repo (either via ssh or https with git, or as fallback with wget or curl if git is not installed)

```
bash -c "$(wget -O - https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"
# OR
bash -c "$(curl https://raw.githubusercontent.com/danielbisar/settings/main/install_dbs.sh)"
# OR (manully)
# if you want to specify another installation location
# - download the install_dbs.sh
# - chmod +x
# - ./install_dbs.sh
# - ./install_dbs.sh INSTALL_DIR
```

## Further setup

There are various helper methods to install dependencies. Use db-<TAB><TAB> to list available functions. Functions to 
install something start with db-install-. Note: This is mainly tested on Ubuntu. Some programs are installed from 
source or other provided binaries, if the versions are much more current than the ones provided by ubuntu. The default
installation location in that case is $DB_ROOT (which defaults to ~/.db).

# What is included

## bash

- db-color_test_256 and db-color_test_24bit which output some test patterns to test your terminals color capabilities 
- fzf configured to use ripgrep
- bash history fix (merges history of different instance, on close)
- color output enabled for grep, fgrep, egrep
- aliases ll, la, l (see environment.sh for what they do); for git: gcm, ga, gd, gl, gs, gp
    - n = nvim; 
    - edit-env = open environment.sh in nvim and source the file after closing
    - edit-setup = edit the setup.sh
- PgUp and PgDown mapped to search the history

## nvim

- PluginManager: Packer
Note: ; is mapped to : and : to ; for normal mode

The following part is OBSOLETE and needs to be updated...
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

