" go to file
let g:alternateSearchPath = 'sfr:../source,sfr:../../source,sfr:../../src,sfr:../src,sfr:../../include,sfr:../include,sfr:../../inc,sfr:../inc'
let g:alternateRelativeFiles = 1

" GTAGS
" nmap <buffer><silent> <leader>d :GtagsCursor<CR>:cclose<CR>
" nmap <buffer><silent> <leader>e :Gtags -r<CR>
" nmap <buffer><silent> <leader>u :AsyncRun! global -u<CR>

" YouCompleteMe
" nmap <buffer><silent> <Leader>F :YcmCompleter FixIt<CR>:ccl<CR>
" nmap <buffer><silent> <Leader>g :YcmCompleter GetType<CR>

" A.vim
nmap <buffer><silent> <Leader>s :A<CR>
nmap <buffer><silent> <Leader>f :IH<CR>
