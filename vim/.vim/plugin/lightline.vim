let g:lightline = {
      \ 'separator': { 'left': '║', 'right': '' },
      \ 'subseparator': { 'left': '┋', 'right': '│' },
      \ 'active': {
      \   'left': [
      \     [ 'relativepath', 'lsp_err', 'lsp_warn', 'lsp_hint', 'lsp_info', 'modified' ],
      \     [ 'readonly', 'paste' ]
      \   ],
      \   'right': [
      \     [],
      \     [],
      \     [ 'lineinfo', 'percent' ],
      \     [],
      \     []
      \  ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath', 'modified' ], [ 'readonly' ] ],
      \   'right': [ ]
      \ },
      \ 'component_function': {
      \   'window_number': 'WindowNumber', 
      \ },
      \ 'component_expand': {
      \   'lsp_err':  'LspErr',
      \   'lsp_warn': 'LspWarn',
      \   'lsp_hint': 'LspHint',
      \   'lsp_info': 'LspInfo',
      \ },
      \ 'component_type': {
      \   'lsp_err':  'error',
      \   'lsp_warn': 'warning',
      \   'lsp_hint': 'info',
      \   'lsp_info': 'info',
      \ },
\ }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ] }

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

" ---------------------------
" vim-lsp diagnostics helpers
" ---------------------------

function! s:lsp_counts() abort
  if exists('*lsp#get_buffer_diagnostics_counts') && get(g:, 'lsp_diagnostics_enabled', 1)
    let l:counts = lsp#get_buffer_diagnostics_counts()
    return {
          \ 'error': get(l:counts, 'error', 0),
          \ 'warning': get(l:counts, 'warning', 0),
          \ 'hint': get(l:counts, 'hint', 0),
          \ 'information': get(l:counts, 'information', 0),
          \ }
  endif
  return { 'error': 0, 'warning': 0, 'hint': 0, 'information': 0 }
endfunction

" Nerd Font icons (change to taste)
let s:icon_err  = '󰈸'
let s:icon_warn = ''
let s:icon_hint = ''
let s:icon_info = ''

function! LspErr() abort
  let l:c = s:lsp_counts()
  return l:c.error > 0 ? printf('%s %d', s:icon_err, l:c.error) : ''
endfunction

function! LspWarn() abort
  let l:c = s:lsp_counts()
  return l:c.warning > 0 ? printf('%s %d', s:icon_warn, l:c.warning) : ''
endfunction

function! LspHint() abort
  let l:c = s:lsp_counts()
  return l:c.hint > 0 ? printf('%s %d', s:icon_hint, l:c.hint) : ''
endfunction

function! LspInfo() abort
  let l:c = s:lsp_counts()
  return l:c.information > 0 ? printf('%s %d', s:icon_info, l:c.information) : ''
endfunction

" Use auocmd to force lightline update.
augroup LIGHTLINE
    autocmd!
    au User lsp_diagnostics_updated call lightline#update()
augroup END

