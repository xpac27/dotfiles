" let g:ycm_clangd_binary_path = 'clangd'
" let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_whitelist = {'cpp': 1, 'c': 1}
let g:ycm_error_symbol = '🔥'
let g:ycm_warning_symbol = '🔔'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_auto_hover = ''
let g:ycm_use_ultisnips_completer = 0
let g:ycm_show_detailed_diag_in_popup = 1
" let g:ycm_show_diagnostics_ui = 1
let g:ycm_always_populate_location_list = 1
" let g:ycm_filepath_completion_use_working_dir = 0
nmap <silent> gD :YcmCompleter GoTo<CR>
nmap <silent> gd :YcmCompleter GoToImprecise<CR>
nmap <silent> gr :YcmCompleter GoToReferences<CR>
nmap <silent> gx :YcmCompleter GoToCallers<CR>
nmap <silent> gX :YcmCompleter GoToCallees<CR>
nmap <silent> gF :YcmCompleter FixIt<CR>
nmap <silent> gR :YcmCompleter RefactorRename 
nmap <silent> gi :YcmDiag<CR>:lwindow<CR>
nmap <silent> <leader>h :YcmCompleter GoToAlternateFile<CR>
nmap K <plug>(YCMHover)

function! s:CustomizeYcmLocationWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Switch back to working window.
  wincmd p
endfunction

autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

" if has("unix")
" 	if filereadable('.clang-format')
" 		au BufWritePre *.cpp,*.c,*.h,*.hpp :YcmCompleter Format
" 	endif
" endif

augroup MyYCMCustom
    autocmd!
    autocmd FileType c,cpp let b:ycm_hover = {
                \ 'command': 'GetDoc',
                \ 'syntax': &filetype
                \ }
augroup END
