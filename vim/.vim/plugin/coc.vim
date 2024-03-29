" let g:coc_global_extensions = [
"   \ 'coc-json',
"   \ 'coc-yaml',
"   \ 'coc-git',
"   \ 'coc-clangd',
"   \ 'coc-lightbulb',
" \]
" 
" " don't give |ins-completion-menu| messages.
" set shortmess+=c
" 
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" 
" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" " Use <c-space> to trigger completion.
" if has('nvim')
"     inoremap <silent><expr> <c-space> coc#refresh()
" else
"     inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocActionAsync('format')
" 
" augroup COC
" 
"     " Use `[g` and `]g` to navigate diagnostics
"     " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"     autocmd FileType c,cpp nmap <silent> [g <Plug>(coc-diagnostic-prev)
"     autocmd FileType c,cpp nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
"     " GoTo code navigation.
"     " nmap <silent> gd <Plug>(coc-definition)
"     autocmd FileType c,cpp nmap <silent> gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
"     autocmd FileType c,cpp nmap <silent> gr <Plug>(coc-references)
" 
"     " Use K to show documentation in preview window
"     autocmd FileType c,cpp nnoremap <silent> K :call ShowDocumentation()<CR>
" 
"     " Highlight symbol under cursor on CursorHold
"     autocmd FileType c,cpp autocmd CursorHold * silent call CocActionAsync('highlight')
" 
"     " Remap for rename current word
"     autocmd FileType c,cpp nmap <silent>gR <Plug>(coc-rename)
" 
"     " Fix autofix problem of current line
"     autocmd FileType c,cpp nmap <silent>gF <Plug>(coc-fix-current)
" 
"     " Use CTRL-S for selections ranges.
"     " Requires 'textDocument/selectionRange' support of language server.
"     autocmd FileType c,cpp nmap <silent> <C-s> <Plug>(coc-range-select)
"     autocmd FileType c,cpp xmap <silent> <C-s> <Plug>(coc-range-select)
" 
"     " Using CocList
"     " Show all diagnostics
"     autocmd FileType c,cpp nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"     " Find symbol of current document
"     autocmd FileType c,cpp nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"     " Show diagnostics
"     autocmd FileType c,cpp nnoremap <silent> <space>d  :CocDiagnostics<cr>
" 
" 	" Using coc-clangd
"     " Switch between h and cpp
"     autocmd FileType c,cpp nnoremap <silent> <leader>h :CocCommand clangd.switchSourceHeader<cr>
" 
" augroup END
" 
" function! CheckBackspace() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction
" 
