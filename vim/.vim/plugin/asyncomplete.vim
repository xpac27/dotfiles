" Tab completion
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,nearest

function! s:asyncomplete_source_priority(source_name) abort
    return get(asyncomplete#get_source_info(a:source_name), 'priority', 0)
endfunction

function! s:asyncomplete_prioritize_sources(left, right) abort
    let l:left_priority = s:asyncomplete_source_priority(a:left)
    let l:right_priority = s:asyncomplete_source_priority(a:right)

    if l:left_priority == l:right_priority
        return a:left ==# a:right ? 0 : a:left ># a:right ? 1 : -1
    endif

    return l:right_priority - l:left_priority
endfunction

function! s:asyncomplete_is_member_completion(typed, startcol) abort
    let l:prefix = a:startcol > 1 ? a:typed[:a:startcol - 2] : ''
    return l:prefix =~# '\%(\.\|->\|::\)$'
endfunction

function! s:asyncomplete_item_score(base, item) abort
    let l:word = get(a:item, 'word', get(a:item, 'abbr', ''))

    if stridx(l:word, a:base) == 0
        return 0
    endif

    if stridx(tolower(l:word), tolower(a:base)) == 0
        return 1
    endif

    return 2
endfunction

function! s:asyncomplete_prioritize_items(base, left, right) abort
    let l:left_score = s:asyncomplete_item_score(a:base, a:left)
    let l:right_score = s:asyncomplete_item_score(a:base, a:right)

    if l:left_score != l:right_score
        return l:left_score - l:right_score
    endif

    let l:left_word = get(a:left, 'word', get(a:left, 'abbr', ''))
    let l:right_word = get(a:right, 'word', get(a:right, 'abbr', ''))

    return l:left_word ==# l:right_word ? 0 : l:left_word ># l:right_word ? 1 : -1
endfunction

function! s:asyncomplete_preprocessor(options, matches) abort
    let l:items = []
    let l:startcols = []

    for l:source_name in sort(keys(a:matches), function('s:asyncomplete_prioritize_sources'))
        let l:matches = a:matches[l:source_name]
        let l:startcol = l:matches['startcol']
        let l:base = a:options['typed'][l:startcol - 1:]

        if l:source_name ==# 'buffer' && s:asyncomplete_is_member_completion(a:options['typed'], l:startcol)
            continue
        endif

        if has_key(asyncomplete#get_source_info(l:source_name), 'filter')
            let l:result = asyncomplete#get_source_info(l:source_name).filter(l:matches, l:startcol, l:base)
            let l:items += l:result[0]
            let l:startcols += l:result[1]
        elseif empty(l:base)
            let l:source_items = sort(copy(l:matches['items']), function('s:asyncomplete_prioritize_items', [l:base]))
            let l:items += l:source_items
            call extend(l:startcols, repeat([l:startcol], len(l:source_items)))
        elseif exists('*matchfuzzypos') && get(g:, 'asyncomplete_matchfuzzy', 1)
            let l:fuzzy_matches = matchfuzzypos(l:matches['items'], l:base, {'key': 'word'})[0]
            let l:source_items = sort(l:fuzzy_matches, function('s:asyncomplete_prioritize_items', [l:base]))
            let l:items += l:source_items
            call extend(l:startcols, repeat([l:startcol], len(l:source_items)))
        else
            let l:source_items = []
            for l:item in l:matches['items']
                if stridx(l:item['word'], l:base) == 0
                    call add(l:source_items, l:item)
                endif
            endfor
            call sort(l:source_items, function('s:asyncomplete_prioritize_items', [l:base]))
            let l:items += l:source_items
            call extend(l:startcols, repeat([l:startcol], len(l:source_items)))
        endif
    endfor

    if empty(l:startcols)
        return
    endif

    let a:options['startcol'] = min(l:startcols)
    call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

let g:asyncomplete_preprocessor = [function('s:asyncomplete_preprocessor')]

function! s:register_buffer_source() abort
    try
        call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'allowlist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ }))
    catch /^Vim\%((\a\+)\)\=:E117/
    endtry
endfunction

augroup VINZ_ASYNCOMPLETE
    autocmd!
    autocmd User asyncomplete_setup call s:register_buffer_source()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)
