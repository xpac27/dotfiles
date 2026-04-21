function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Initialize configuration dictionary
let g:fzf_vim = {}
" Use location list instead of quickfix list
let g:fzf_vim.listproc = { list -> fzf#vim#listproc#location(list) }

" CTRL-Q to open in quickfix list
let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" Initialize configuration dictionary
let g:fzf_vim = {}

" Use location list instead of quickfix list
let g:fzf_vim.listproc = { list -> fzf#vim#listproc#location(list) }

" CTRL-A to select all
if has("unix")
    let g:fzf_preview_window = ['right,50%', 'ctrl-/']
	command! -bang -nargs=? BLines call fzf#vim#buffer_lines({'options': ['--bind=ctrl-a:select-all']})
	command! -bang -nargs=? Files call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all']}), <bang>0)
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --fixed-strings '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all']}), <bang>0)
	command! -bang -nargs=* -complete=dir FindFiles call fzf#vim#grep('rg --vimgrep --fixed-strings --max-count=1 '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all']}), <bang>0)
else
	let g:fzf_preview_window = []
	command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'source': 'rg --files --vimgrep --color=never', 'options': ['--bind=ctrl-a:select-all']}, <bang>0)
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep  '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all']}, <bang>0)
	command! -bang -nargs=* -complete=dir FindFiles call fzf#vim#grep('rg --vimgrep --fixed-strings --max-count=1 '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all']}, <bang>0)
endif

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Find 
nnoremap <leader>G :FindFiles 
nnoremap <leader>l :BLines<CR>

let g:fzf_layout = { 'down': '~60%' }

let g:fzf_colors = {
    \ 'fg':         ['fg', 'Normal'],
    \ 'bg':         ['bg', 'FzfBackground', 'Normal'],
    \ 'preview-fg': ['fg', 'FzfBackground', 'Normal'],
    \ 'preview-bg': ['bg', 'FzfBackground', 'Normal'],
    \ 'fg+':        ['fg', 'Pmenu'],
    \ 'bg+':        ['bg', 'Pmenu'],
    \ 'hl':         ['fg', 'FzfMatch', 'Pmenu'],
    \ 'hl+':        ['fg', 'FzfMatchSelected', 'FzfSelected'],
    \ 'gutter':     ['bg', 'StatusLine'],
    \ 'info':       ['fg', 'Comment'],
    \ 'border':     ['fg', 'Pmenu'],
    \ 'prompt':     ['fg', 'Pmenu'],
    \ 'pointer':    ['fg', 'PmenuSel'],
    \ 'marker':     ['fg', 'FzfMarker', 'WarningMsg'],
    \ 'spinner':    ['fg', 'InfoMsg'],
    \ 'header':     ['fg', 'Comment'] }

autocmd! FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
