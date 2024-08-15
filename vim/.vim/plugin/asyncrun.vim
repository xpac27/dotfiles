let g:asyncrun_open = 20
let g:asyncrun_save = 2
let g:asyncrun_exit = "if g:asyncrun_code == 0 | cclose | endif"
let g:asyncrun_trim = 1
let g:asyncrun_save = 1

augroup ASYNCRUN
    autocmd FileType qf setlocal wincolor=QuickFixBackground
    autocmd FileType qf setlocal nonumber
    autocmd FileType qf setlocal norelativenumber
    autocmd FileType qf setlocal fillchars=eob:\ 
augroup END
