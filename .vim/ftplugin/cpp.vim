" go to file
g:alternateSearchPath = 'sfr:.,sfr:../source,sfr:../../source,sfr:../../src,sfr:../src,sfr:../../include,sfr:../include,sfr:../../inc,sfr:../inc'

" better lambda indent
setlocal cindent cino='j1,(0,ws,Ws'

" LSP
if executable('cquery')
    nmap <buffer><silent> <leader>d :LspDefinition<CR>
    nmap <buffer><silent> <leader>e :LspReferences<CR>
    nmap <buffer><silent> <leader>t :LspTypeDefinition<CR>
    nmap <buffer><silent> <leader>r :LspRename<CR>
endif

" YouCompleteMe
nmap <buffer><silent> <Leader>f :YcmCompleter FixIt<CR>:ccl<CR>
nmap <buffer><silent> <Leader>g :YcmCompleter GetType<CR>

" A.vim
nmap <buffer><silent> <Leader>s :A<CR>
nmap <buffer><silent> <Leader>f :IH<CR>

" Clang-format
nmap <buffer> <SPACE> :pyf /usr/share/clang/clang-format.py<CR>

" Compile
nmap <buffer> <Leader>m :AsyncRun make compile<CR>
nmap <buffer> <Leader>c :AsyncStop<CR>
nmap <buffer> <Leader>C :AsyncStop!<CR>

