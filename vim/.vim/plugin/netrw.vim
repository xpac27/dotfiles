let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_liststyle = 3
let g:netrw_sort_options = 'i'
let g:netrw_winsize = -32
let g:netrw_list_hide = '.*\.o$,.*\.so$,.*\.dwo$'
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search

nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <Leader>da :Lexplore<CR>

function! NetrwMapping()
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    nmap <buffer> H u
    nmap <buffer> h -^
    nmap <buffer> l <CR>

    nmap <buffer> . gh
    nmap <buffer> P <C-w>z

    nmap <buffer> L <CR>:Lexplore<CR>
    nmap <buffer> <Leader>dd :Lexplore<CR>

    nmap <buffer> ff %:w<CR>:buffer #<CR>
    nmap <buffer> fe R
    nmap <buffer> fc mc
    nmap <buffer> fC mtmc
    nmap <buffer> fx mm
    nmap <buffer> fX mtmm
    nmap <buffer> f; mx
endfunction
