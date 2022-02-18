set nocompatible

" instead of abonden a buffer when it is not visible mark it as hidden
" so you will get ask to save changes when closing vim
set hidden

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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" by default ignore case when searching / use \c to search case sensitive
set ignorecase
set smartcase

exe "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

set scrolloff=5

" display all matching files with TAB completion
set wildmenu

" disable python2 
let g:loaded_python_provider = 0



let g:ale_disable_lsp = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''


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
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'

    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    Plug 'dense-analysis/ale'
    Plug 'puremourning/vimspector'
    Plug 'sheerun/vim-polyglot'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " status bar
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'

    " frequently used color themes
    Plug 'tomasiser/vim-code-dark'
    Plug 'overcache/NeoSolarized'
call plug#end()


" extensions for the coc extension
let g:coc_global_extensions=[
            \ 'coc-marketplace',
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-git',
            \ 'coc-lua',
            \ 'coc-omnisharp',
            \ 'coc-json',
            \ 'coc-snippets',
            \ 'coc-sql',
            \ 'coc-xml',
            \ 'coc-vimlsp' ]

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
" let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
" if executable(s:clip)
"    augroup WSLYank
"        autocmd!
"        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
"    augroup END
" end




let $BASE = '$DB_SETTINGS_VIM_BASE'

source $BASE/colors.vim
source $BASE/filetypes.vim
source $BASE/netrw.vim
source $BASE/ansihighlight.vim

" visual block drag
runtime plugin/dragvisuals.vim

command! CleanAllCarriageReturns :%s/\r$//
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis  | wincmd p | diffthis
command! UpdateAll :PlugUpgrade | :PlugUpdate | :CocUpdate

" helpful commands to edit and reload the vimrc file
command! Settings edit $BASE/common.vim
command! SettingsColors edit $BASE/colors.vim
command! SettingsFiletypes edit $BASE/filetypes.vim
command! SettingsNetrw edit $BASE/netrw.vim
command! SettingsInput edit $BASE/input.vim
command! ReloadSettings source $BASE/common.vim

let &runtimepath.=',' . escape($BASE, '\,')

source $BASE/input.vim
