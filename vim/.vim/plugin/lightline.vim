let g:lightline = {
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'relativepath', 'modified', 'cocstatus' ], [ 'readonly', 'paste' ] ],
      \   'right': [ [],[],[ 'lineinfo', 'percent', 'filetype', 'fileencoding' ], [], [] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath', 'modified', 'cocstatus' ], [ 'readonly' ] ],
      \   'right': [ ]
      \ },
      \ 'component': {
      \   'arrow_right': '  '
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'window_number': 'WindowNumber', 
      \ },
\ }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ] }

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
