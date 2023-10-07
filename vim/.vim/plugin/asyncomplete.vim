" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Preview Window
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
