set termguicolors

colorscheme codedark

highlight Normal        ctermbg=black  guibg=#070707  ctermfg=lightgray guifg=lightgray
highlight NonText       ctermbg=black  guibg=#070707  ctermfg=lightgray guifg=#a0a0a0
highlight EndOfBuffer   ctermbg=black  guibg=#0F0F0F  ctermfg=lightgray guifg=#a0a0a0

" neovim popup colors
" Pmenu = menu item, PmenuSel = selected menu item, PmenuSbar = scroll bar,
" PmenuThumb = thumb of scrollbar
highlight Pmenu         ctermbg=gray   guibg=gray   ctermfg=black   guifg=black
highlight PmenuSel      ctermfg=black  guifg=black 

highlight LineNr        ctermbg=gray   guibg=#1F1F1F  ctermfg=black guifg=#a0a0a0
"highlight CursorLineNr  xxx ctermfg=11 gui=bold guifg=Yellow

" color the char at column 81, 121 and 161
highlight ColorColumn guibg=#101010
set colorcolumn=81,121,161
"call matchadd('ColorColumn', '\%81v', 100)
"call matchadd('ColorColumn', '\%121vi', 100)


