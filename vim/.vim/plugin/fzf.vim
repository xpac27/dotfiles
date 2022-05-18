function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" CTRL-Q to open in quickfix list
let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" CTRL-A to select all
if has("unix")
	command! -bang -nargs=? GFiles call fzf#vim#files(<q-args>, {'options': ['--bind=ctrl-a:select-all']}, <bang>0)
else
    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case -tcpp -tcsharp -tddf -tproto -tbuild ', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
    command! -bang -nargs=? -complete=dir FilesAll call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case -tanything', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
endif

if has("unix")
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all']}), <bang>0)
else
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAll call fzf#vim#grep('rg --vimgrep --smart-case -tanything '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAllFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case -tanything '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
endif

nnoremap <leader>f :GitFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Find 
nnoremap <leader>l :BLines<CR>

let g:fzf_tags_command = 'ctags -R --extra=+q'
let g:fzf_layout = { 'down': '~60%' }
let g:fzf_preview_window = []
