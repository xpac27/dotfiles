if has("unix")
    packadd termdebug
endif

silent let s:loaded = exists(":Run")
if s:loaded == 0
    let g:termdebug_config = {}
    let g:termdebug_config['wide'] = 1
    let g:termdebug_config['popup'] = 1
    let g:termdebug_config['winbar'] = 0
    hi debugPC guibg=#6272a4
    hi debugBreakPoint guibg=#ff79c6

    noremap <silent> <leader>td :Termdebug<cr>

    nnoremap <F5> :Run<CR>
    nnoremap <F6> :Continue<CR>
    nnoremap <F7> :Finish<CR>
    nnoremap <F8> :Over<CR>
    nnoremap <F10> :Step<CR>

    nnoremap <leader>dr :Run<CR>
    nnoremap <leader>dc :Continue<CR>
    nnoremap <leader>ds :Step<CR>
    nnoremap <leader>dn :Over<CR>
    nnoremap <leader>df :Finish<CR>
    nnoremap <leader>db :Break<CR>
    nnoremap <leader>dd :Clear<CR>

    nnoremap <leader>dl :call TermDebugSendCommand('info locals')<CR>
endif

