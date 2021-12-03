      " \ 'colorscheme': 'PaperColor_light',
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'window_number', 'relativepath', 'modified', 'cocstatus' ], [ 'readonly', 'paste' ] ],
      \   'right': [ [],[],[ 'lineinfo', 'percent', 'filetype', 'fileencoding' ], [], [] ]
      \ },
      \ 'inactive': {
      \   'left': [ ['window_number' ], [ 'relativepath' ], [ 'readonly' ] ],
      \   'right': []
      \ },
      \ 'component': {
      \   'arrow_right': '  '
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
	  \   'window_number': 'WindowNumber', 
      \ },
\ }

let g:lightline.inactive = {
    \ 'left': [ [ 'filename' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ] }

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
