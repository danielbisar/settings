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

" by default ignore case when searching / use \c to search case sensitive
set ignorecase
set smartcase




command! CleanAllCarriageReturns :%s/\r$//












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

    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " status bar 
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
call plug#end()

"""""""""" omnisharp
" Don't autoselect first omnicomplete option, show options even if there is
" only
" " one (so the preview documentation is accessible). Remove 'preview',
" 'popup'
" " and 'popuphidden' if you don't want to see any documentation whatsoever.
" " Note that neovim does not support `popuphidden` or `popup` yet:
" " https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
    set completeopt=longest,menuone,popuphidden
    " Highlight the completion documentation popup background/foreground the
    " same as
    " the completion menu itself, for better readability with highlighted
    " documentation.
    set completepopup=highlight:Pmenu,border:off
else
    set completeopt=longest,menuone,preview
    " Set desired preview window height for viewing documentation.
    set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Enable snippet completion, using the ultisnips plugin
let g:OmniSharp_want_snippet=1







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



















"""""""""""""" KEYMAP
nnoremap <silent> <F3> :Files<CR>
nnoremap <silent> <F4> :Rg<CR>
nnoremap <F12> :OmniSharpGotoDefinition<CR> 

" insert mode keymaps
inoremap <F12> <ESC>:OmniSharpGotoDefinition<CR>











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
source $BASE/netrw.vim

" helpful commands to edit and reload the vimrc file
command! Settings edit ~/.vimrc
command! SettingsColors edit $BASE/colors.vim
command! SettingsFiletypes edit $BASE/filetypes.vim
command! SettingsNetrw edit $BASE/netrw.vim

command! SettingsReload source ~/.vimrc


