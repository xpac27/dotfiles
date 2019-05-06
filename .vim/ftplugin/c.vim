" go to file
g:alternateSearchPath = 'sfr:.,sfr:../source,sfr:../../source,sfr:../../src,sfr:../src,sfr:../../include,sfr:../include,sfr:../../inc,sfr:../inc'

" GTAGS
nmap <buffer><silent> <leader>d :GtagsCursor<CR>:cclose<CR>
nmap <buffer><silent> <leader>e :Gtags -r<CR>
nmap <buffer><silent> <leader>u :AsyncRun! global -u<CR>

" YouCompleteMe
nmap <buffer><silent> <Leader>f :YcmCompleter FixIt<CR>:ccl<CR>
nmap <buffer><silent> <Leader>g :YcmCompleter GetType<CR>

" A.vim
nmap <buffer><silent> <Leader>s :A<CR>
nmap <buffer><silent> <Leader>f :IH<CR>

" Clang-format
nmap <buffer> <SPACE> :pyf /usr/share/clang/clang-format.py<CR>
