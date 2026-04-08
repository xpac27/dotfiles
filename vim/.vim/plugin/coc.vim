" Coc owns both LSP and completion for this trial.
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \]

" Do not show ins-completion-menu messages.
set shortmess+=c

let g:coc_borderchars = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
let g:coc_border_joinchars = [' ', ' ', ' ', ' ']

function! s:check_backspace() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

function! s:show_documentation() abort
    if exists('*CocAction') && CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

function! s:coc_format() abort
    if exists('*CocAction')
        call CocAction('format')
    endif
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_backspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

if has('nvim')
    inoremap <silent><expr> <C-Space> coc#refresh()
else
    inoremap <silent><expr> <C-@> coc#refresh()
endif

command! -nargs=0 Format call s:coc_format()

augroup VINZ_COC
    autocmd!
    autocmd FileType c,cpp nmap <silent><buffer> [g <Plug>(coc-diagnostic-prev)
    autocmd FileType c,cpp nmap <silent><buffer> ]g <Plug>(coc-diagnostic-next)
    autocmd FileType c,cpp nmap <silent><buffer> <Left> <Plug>(coc-diagnostic-prev)
    autocmd FileType c,cpp nmap <silent><buffer> <Right> <Plug>(coc-diagnostic-next)
    autocmd FileType c,cpp nmap <silent><buffer> gd <Plug>(coc-definition)
    autocmd FileType c,cpp nmap <silent><buffer> gD <Plug>(coc-type-definition)
    autocmd FileType c,cpp nmap <silent><buffer> gr <Plug>(coc-references)
    autocmd FileType c,cpp nmap <silent><buffer> gS :<C-u>CocList outline<CR>
    autocmd FileType c,cpp nmap <silent><buffer> gs :<C-u>CocList symbols<CR>
    autocmd FileType c,cpp nmap <silent><buffer> gh :<C-u>call CocActionAsync('showSuperTypes')<CR>
    autocmd FileType c,cpp nmap <silent><buffer> ga <Plug>(coc-codeaction)
    autocmd FileType c,cpp nnoremap <silent><buffer> K :call <SID>show_documentation()<CR>
    autocmd FileType c,cpp nmap <silent><buffer> gR <Plug>(coc-rename)
    autocmd FileType c,cpp nmap <silent><buffer> gF <Plug>(coc-fix-current)
    autocmd FileType c,cpp nnoremap <silent><buffer> gi :<C-u>CocDiagnostics<CR>
    autocmd FileType c,cpp nnoremap <silent><buffer> <leader>h :<C-u>CocCommand clangd.switchSourceHeader<CR>
    autocmd CursorHold * if exists('*CocActionAsync') | silent call CocActionAsync('highlight') | endif
    autocmd BufWritePre *.cpp,*.c,*.h,*.hpp if has('unix') && filereadable('.clang-format') | call s:coc_format() | endif
augroup END
