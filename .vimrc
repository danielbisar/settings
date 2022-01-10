set nocompatible

" instead of abonden a buffer when it is not visible mark it as hidden
" so you will get ask to save changes when closing vim
set hidden

" try to automatically detect file types
filetype on
filetype indent on
" currently no plugins are used but if the following could be helpful
" filetype plugin on

" code editing
set expandtab
set tabstop=4
set shiftwidth=4

" enable line numbers
set number

" by default ignore case when searching / use \c to search case sensitive
set ignorecase
set smartcase

" color settings
set term=screen-256color
set t_ut=

" helpful commands to edit and reload the vimrc file
command Settings edit ~/.vimrc
command ReloadSettings source ~/.vimrc

" finding files
" the downside of the below setting is that for large projects it is 
" very slow - so disable for now
"set path+=**

" display all matching files with TAB completion
set wildmenu

" TIPS: :find and use * for fuzzy search, :b lets you auto-complete any open buffer



" plugin configuration
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" install vimplug if not exists
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    " The default plugin directory will be as follows:
    "   - Vim (Linux/macOS): '~/.vim/plugged'
    "   - Vim (Windows): '~/vimfiles/plugged'
    "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
    " You can specify a custom plugin directory by passing it as the argument
    "   - e.g. `call plug#begin('~/.vim/plugged')`
    "   - Avoid using standard Vim directory names like 'plugin'

    " Make sure you use single quotes

    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"""""""""""""" external tools
" the fzf plugin requires fzf to be installed
" setup :grep to ripgrep (rg)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

"""""""""""""" KEYMAP
nnoremap <silent> <F3> :Files<CR>
nnoremap <silent> <F4> :Rg<CR>


""""""" WSL specific settings """"""""""""
" WSL (Windows) using system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end
