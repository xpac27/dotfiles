if exists('theme') && theme == 'light'
    let $BAT_THEME = 'gruvbox-light'
else
    let $BAT_THEME = 'gruvbox-dark'
endif

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" https://minsw.github.io/fzf-color-picker/
if exists('theme') && theme == 'light'
    let fzf_gruvbox = ''
else 
    let fzf_gruvbox = 'fg:#a89984,bg:#282828,hl:#fabd2f,fg+:#fbf1c7,bg+:#282828,hl+:#fabd2f,info:#fbf1c7,prompt:#fb4934,pointer:#fbf1c7,marker:#d3869b,spinner:#fabd2f,header:#8ec07c'
endif

" CTRL-Q to open in quickfix list
let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" CTRL-A to select all
if has("unix")
	command! -bang -nargs=? GFiles call fzf#vim#files(<q-args>, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvbox]}, <bang>0)
else
    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case -tcpp -tcsharp -tddf -tproto -tbuild ', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
    command! -bang -nargs=? -complete=dir FilesAll call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case -tanything', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
endif

if has("unix")
    nmap <leader>f :GitFiles<CR>
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvbox]}), <bang>0)
else
    nmap <leader>f :Files<CR>
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAll call fzf#vim#grep('rg --vimgrep --smart-case -tanything '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAllFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case -tanything '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
endif

nmap <leader>b :Buffers<CR>
nmap <leader>g :Find 
nmap <leader>l :BLines<CR>

let g:fzf_tags_command = 'ctags -R --extra=+q'
let g:fzf_layout = { 'down': '~60%' }
let g:fzf_preview_window = []

