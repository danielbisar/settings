"""""""""""""" KEYMAP
nnoremap <silent> <F2> :Buffers<CR>
nnoremap <silent> <F3> :Files<CR>
nnoremap <silent> <F4> :Rg<CR>
"nnoremap <F12> :OmniSharpGotoDefinition<CR> 

" insert mode keymaps
"inoremap <F12> <ESC>:OmniSharpGotoDefinition<CR>

let visualstudio='/mnt/c/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe'

if executable(visualstudio)
    command! Build execute '!' . shellescape(visualstudio) . '/Run ' . 
    nnoremap <silent> <F5> :Build<CR>
end


