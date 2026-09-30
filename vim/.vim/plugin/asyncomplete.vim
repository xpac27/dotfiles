" Show suggestions without inserting or selecting one automatically.
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect

" Temporary LSP adapter: filter candidates without replacing vim-lsp's order.
" TODO: Move the LSP handling into asyncomplete-lsp's per-source filter hook.
" That plugin knows the server and completion metadata, so preserving ranking,
" filterText and snippet labels belongs there, rather than in personal config.
function! s:asyncomplete_preprocessor(options, matches) abort
    let l:items = []
    let l:startcols = []
    for [l:source_name, l:matches] in items(a:matches)
        let l:startcol = l:matches['startcol']
        let l:filter = {'name': get(g:, 'asyncomplete_matchfuzzy', 1) ? 'fuzzy' : 'prefix'}
        if l:source_name =~# '^asyncomplete_lsp_'
            let l:server_name = strpart(l:source_name, strlen('asyncomplete_lsp_'))
            let l:config = get(lsp#get_server_info(l:server_name), 'config', {})
            let l:filter = get(l:config, 'filter', l:filter)
        endif
        let l:source_items = lsp#omni#_filter_completion_items(
            \ l:matches['items'], strpart(a:options['typed'], l:startcol - 1), l:filter['name'], {
            \ 'preserve_order': v:true,
            \ 'start_character': strchars(strpart(a:options['typed'], 0, l:startcol - 1)),
            \ })
        if !empty(l:source_items)
            call extend(l:items, l:source_items)
            call add(l:startcols, l:startcol)
        endif
    endfor

    if !empty(l:items)
        " asyncomplete owns the input context; only update our copy.
        let l:context = extend(copy(a:options), {'startcol': min(l:startcols)})
        call asyncomplete#preprocess_complete(l:context, l:items)
    endif
endfunction

let g:asyncomplete_preprocessor = [function('s:asyncomplete_preprocessor')]

" Navigate the popup with Tab/Shift-Tab; Enter accepts it without a newline.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Force refresh completion.
imap <c-space> <Plug>(asyncomplete_force_refresh)
