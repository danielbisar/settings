set nocompatible

" instead of abonden a buffer when it is not visible mark it as hidden
" so you will get ask to save changes when closing vim
set hidden

" try to automatically detect file types
filetype on
filetype indent on
" currently no plugins are used but if the following could be helpful
" filetype plugin on

set expandtab
set tabstop=4
set shiftwidth=4

" by default ignore case when searching / use \c to search case sensitive
set ignorecase
set smartcase

" color settings
set term=screen-256color
set t_ut=

command Settings edit ~/.vimrc
command ReloadSettings source ~/.vimrc

" finding files
" the downside of the below setting is that for large projects it is 
" very slow - so disable for now
"set path+=**

" display all matching files with TAB completion
set wildmenu

" TIPS: :find and use * for fuzzy search, :b lets you auto-complete any open buffer



""""""" WSL specific settings """"""""""""
" WSL (Windows) using system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end


