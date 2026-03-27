setlocal shiftwidth=2
nnoremap <buffer> <leader>m :AsyncRun ponyc -d<CR>

augroup VINZ_pony
    autocmd!

    " disable trailing whitespace removal from polyglote's pony plugin
    autocmd BufNewFile,BufRead * autocmd! pony

    " re-enable it but only when saving file
    autocmd BufWritePre <buffer> call pony#ClearTrailingSpace(1, 0, 1)
augroup END
