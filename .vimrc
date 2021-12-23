set nocompatible

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

command Settings e ~/.vimrc

" finding files
"let &path = "./**," . &path
set path+=**

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


