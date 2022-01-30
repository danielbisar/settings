
set mouse=a

"""""""""""""" KEYMAP
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap <F2>   :Buffers<CR>
nnoremap <F3>   :Files<CR>
nnoremap <F4>   :Rg<CR>
" CocAction('jumpImplementation'), jumpTypeDefinition, 
"
nnoremap <F5>   :!dotnet run<CR>

"nnoremap <F5>       :CocAction('refactor')<CR>
"nnoremap <F6>       :CocAction<CR>
"nnoremap <F10>      :CocAction('jumpReferences')<CR>
"nnoremap <S-F12>    :CocAction('jumpImplementation')<CR>
"nnoremap <S-F12>  :CocAction('jumpDeclaration')<CR>
"nnoremap <F12>    :CocAction('jumpDefinition')<CR>

" insert mode keymaps
"inoremap <F12> <ESC>:OmniSharpGotoDefinition<CR>

let visualstudio='/mnt/c/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe'

if executable(visualstudio)
    command! Build execute '!' . shellescape(visualstudio) . '/Run ' . 
    nnoremap <silent> <F5> :Build<CR>
end

" visual dragging of selected code
vmap <expr> <S-LEFT>  DVB_Drag('left')
vmap <expr> <S-RIGHT> DVB_Drag('right')
vmap <expr> <S-DOWN>  DVB_Drag('down')
vmap <expr> <S-UP>    DVB_Drag('up')
vmap <expr> D         DVB_Duplicate()

" ctrl-p to paste content from clipboard
nnoremap <C-p>  "+p

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

