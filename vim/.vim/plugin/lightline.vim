let g:lightline = {
      \ 'separator': { 'left': '║', 'right': '' },
      \ 'subseparator': { 'left': '┋', 'right': '│' },
      \ 'active': {
      \   'left': [ [ 'relativepath', 'lsp_status', 'modified' ], [ 'readonly', 'paste' ] ],
      \   'right': [ [],[],[ 'lineinfo', 'percent', 'filetype', 'fileencoding' ], [], [] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath', 'modified' ], [ 'readonly' ] ],
      \   'right': [ ]
      \ },
      \ 'component_function': {
      \   'window_number': 'WindowNumber', 
      \   'lsp_status': 'LspStatus', 
      \ },
\ }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ] }

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

function! LspStatus()
  let l:msg = ''
  let l:errors = 0
  let l:warnings = 0
  let l:hints = 0
  let l:information = 0
  if exists('*lsp#get_buffer_diagnostics_counts')
              \ && get(g:, 'lsp_diagnostics_enabled', 1)
      let l:counts = lsp#get_buffer_diagnostics_counts()
      let l:errors = get(l:counts, 'error', '')
      let l:warnings = get(l:counts, 'warning', '')
      let l:hints = get(l:counts, 'hint', '')
      let l:information = get(l:counts, 'information', '')
  endif
  if l:errors > 0
      let l:msg .= printf('🔥%d ', l:errors)
  endif
  if l:warnings > 0
      let l:msg .= printf('💣%d ', l:warnings)
  endif
  if l:hints > 0
      let l:msg .= printf('💡%d ', l:hints)
  endif
  if l:information > 0
      let l:msg .= printf('👁️%d', l:information)
  endif
  return substitute(l:msg, '\s*$', '', '')
endfunction

" Use auocmd to force lightline update.
augroup LIGHTLINE
    autocmd!
    au User lsp_diagnostics_updated call lightline#update()
augroup END

