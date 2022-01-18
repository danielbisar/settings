set nocompatible

" instead of abonden a buffer when it is not visible mark it as hidden
" so you will get ask to save changes when closing vim
set hidden

set mouse=n

" try to automatically detect file types
filetype on
filetype indent on
filetype plugin on

" code editing
set expandtab
set tabstop=4
set shiftwidth=4

" enable line numbers
set number
" always show the sign column, so that linting errors do not make the number
" column wider or smaller
set scl=yes

" by default ignore case when searching / use \c to search case sensitive
set ignorecase
set smartcase


" color the char at column 81
highlight ColorColumn guibg=#101010
set colorcolumn=81,121,161
"call matchadd('ColorColumn', '\%81v', 100)
"call matchadd('ColorColumn', '\%121vi', 100)

exe "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"function! SpecialHighlightOnNext(blinktime)
"    let [bufnum, lnum, col, off] = getpos('.')
"    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"    let target_pat = '\c\%#'.@/
"    let blinks = 3
"
"    for n in range(1, blinks)
"        let red = matchadd('WhiteOnRed', target_pat, 101)
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
"        call matchdelete(red)
"        redraw
"        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
"    endfor
"endfunction

"nnoremap <silent> n     n:call SpecialHighlightOnNext(0.4)<CR>
"nnoremap <silent> N     N:call SpecialHighlightOnNext(0.4)<CR>

command! CleanAllCarriageReturns :%s/\r$//
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis  | wincmd p | diffthis




" visual block drag
runtime plugin/dragvisuals.vim

vmap <expr> <S-LEFT>  DVB_Drag('left')
vmap <expr> <S-RIGHT> DVB_Drag('right')
vmap <expr> <S-DOWN>  DVB_Drag('down')
vmap <expr> <S-UP>    DVB_Drag('up')
vmap <expr> D         DVB_Duplicate()


set scrolloff=5


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

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'

    " status bar
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    Plug 'tomasiser/vim-code-dark'
call plug#end()

colorscheme codedark

let g:coc_global_extensions=[ 'coc-marketplace', 'coc-omnisharp', 'coc-json' ]


let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }


let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype'] ] }





"""""""""""""" external tools
" the fzf plugin requires fzf to be installed
" setup :grep to ripgrep (rg)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

















""""""" WSL specific settings """"""""""""
" WSL (Windows) using system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end











" source from http://threkk.medium.com/how-to-have-a-neovim-configuration-compatible-with-vim-b5a46723145es
let is_nvim = has('nvim')
let $BASE = '$HOME/src/settings/vim'

if is_nvim
    source $BASE/neovim-only.vim
else
    source $BASE/vim-only.vim
endif

source $BASE/colors.vim
source $BASE/filetypes.vim
source $BASE/keymap.vim
source $BASE/netrw.vim

" helpful commands to edit and reload the vimrc file
command! Settings edit ~/.vimrc
command! SettingsColors edit $BASE/colors.vim
command! SettingsFiletypes edit $BASE/filetypes.vim
command! SettingsNetrw edit $BASE/netrw.vim
command! SettingsKeymap edit $BASE/keymap.vim

command! ReloadSettings source ~/.vimrc

let &runtimepath.=',' . escape($BASE, '\,')

