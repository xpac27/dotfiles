let g:asyncrun_open = 20
let g:asyncrun_save = 2
let g:asyncrun_exit = "if g:asyncrun_code == 0 | cclose | endif"
let g:asyncrun_trim = 1
let g:asyncrun_save = 1

highlight QuickFixBackground guifg=#666666 guibg=#2a2a2a

augroup ASYNCRUN
    autocmd FileType qf setlocal wincolor=QuickFixBackground
    autocmd FileType qf setlocal nonumber
    autocmd FileType qf setlocal norelativenumber
    autocmd FileType qf setlocal fillchars=eob:\ 

    if has("unix")
    else
        autocmd FileType qf setlocal compiler=custom_msvc
        " autocmd FileType qf setlocal compiler=msvc
        " autocmd FileType qf setlocal compiler=msbuild
    endif
augroup END
