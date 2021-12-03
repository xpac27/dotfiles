" if has('win64') || has('win32')
"     set pythonthreehome=$HOME\\AppData\\Local\\Programs\\Python\\Python38
"     set pythonthreedll=$HOME\\AppData\\Local\\Programs\\Python\\Python38\\python38.dll
" endif

" let g:ycm_clangd_binary_path = 'clangd'
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_filetype_whitelist = {'cpp': 1, 'c': 1}
" let g:ycm_error_symbol = '🔥'
" let g:ycm_warning_symbol = '🔔'
" let g:ycm_enable_diagnostic_highlighting = 1
" let g:ycm_auto_hover = ''
" let g:ycm_always_populate_location_list = 0
" let g:ycm_filepath_completion_use_working_dir = 0
" nmap <silent> gD :YcmCompleter GoTo<CR>
" nmap <silent> gd :YcmCompleter GoToImprecise<CR>
" nmap <silent> gr :YcmCompleter GoToReferences<CR>
" nmap <silent> gF :YcmCompleter FixIt<CR>
" nmap <silent> gR :YcmCompleter RefactorRename 
" nmap K <plug>(YCMHover)

" if has("unix")
" 	if filereadable('.clang-format')
" 		au BufWritePre *.cpp,*.c,*.h,*.hpp :YcmCompleter Format
" 	endif
" endif

" augroup MyYCMCustom
"     autocmd!
"     autocmd FileType c,cpp let b:ycm_hover = {
"                 \ 'command': 'GetDoc',
"                 \ 'syntax': &filetype
"                 \ }
" augroup END
