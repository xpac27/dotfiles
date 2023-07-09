" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_whitelist = {'cpp': 1, 'c': 1}
let g:ycm_error_symbol = '🩸'
let g:ycm_warning_symbol = '👻'
let g:ycm_auto_hover = ''
let g:ycm_use_ultisnips_completer = 0
let g:ycm_show_detailed_diag_in_popup = 1
let g:ycm_echo_current_diagnostic = 1
let g:ycm_update_diagnostics_in_insert_mode = 1
let g:ycm_always_populate_location_list = 1
" let g:ycm_filepath_completion_use_working_dir = 0
let g:ycm_enable_semantic_highlighting=1
let g:ycm_log_level = 'critical'
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

" Diag popup
hi ErrorMsg guibg=#ff5555 guifg=#f8f8f2
hi BorderColor guifg=#44475a guifg=NONE

function! s:CustomizeYcmLocationWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Switch back to working window.
  wincmd p
endfunction

augroup MyYCMCustom
    autocmd!

    autocmd FileType c,cpp let b:ycm_hover = {
                \ 'command': 'GetDoc',
                \ 'syntax': &filetype,
                \ 'popup_params': {
                \     'maxwidth': 80,
                \     'border': [],
                \     'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
                \     'borderhighlight': ['BorderColor'],
                \   },
                \ }

    autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

    if has("unix") && filereadable('.clang-format')
        autocmd BufWritePre *.cpp,*.c,*.h,*.hpp :YcmCompleter Format
    endif
augroup END
