" go to file
let g:alternateSearchPath = 'sfr:../source,sfr:../../source,sfr:../../src,sfr:../src,sfr:../../include,sfr:../include,sfr:../../inc,sfr:../inc'
let g:alternateRelativeFiles = 1

" better lambda indent
setlocal cindent cino='j1,(0,ws,Ws'

" LSP
" if executable('cquery')
"     nmap <buffer><silent> <leader>d :LspDefinition<CR>
"     nmap <buffer><silent> <leader>e :LspReferences<CR>
"     nmap <buffer><silent> <leader>t :LspTypeDefinition<CR>
"     nmap <buffer><silent> <leader>r :LspRename<CR>
" endif

" YouCompleteMe
" nmap <buffer><silent> <Leader>F :YcmCompleter FixIt<CR>:ccl<CR>
" nmap <buffer><silent> <Leader>g :YcmCompleter GetType<CR>

" A.vim
nmap <buffer><silent> <Leader>s :w<CR>:A<CR>
nmap <buffer><silent> <Leader>f :w<CR>:IH<CR>

" Compile
nmap <buffer> <Leader>m :AsyncRun make compile<CR>
