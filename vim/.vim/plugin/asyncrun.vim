let g:asyncrun_save = 2
let g:asyncrun_trim = 1
let g:asyncrun_save = 2
let g:asyncrun_last = 3
let g:asyncrun_timer = 500

if has("unix")
    let g:asyncrun_exit = "if g:asyncrun_code != 0 | copen | wincmd w | else | cclose | endif"

    command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

    nnoremap <silent> <leader>m :Make test NO_COLOR=1<CR>
else
    let g:asyncrun_open = 20
    let g:asyncrun_exit = "if g:asyncrun_code == 0 | cclose | endif"

    command! Ninja AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_BUILD %:p
    command! NinjaBO AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_BUILD Extension.BattlefieldOnline_all
    command! NinjaAll AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_BUILD all

    command! Test let l = line('.') | execute 'AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_TEST %:p' l
    command! TestAll let l = line('.') | execute 'AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_TEST %:p'
    command! IntTest AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_INT_TEST
    command! UnitTest AsyncRun -strip ruby F:\vinz\Github\scripts\compile.rb NINJA_UNI_TEST

    nnoremap <silent> <leader>m :Ninja<CR>
    nnoremap <silent> <leader>mm :NinjaAll<CR>
    nnoremap <silent> <leader>t :Test<CR>
    nnoremap <silent> <leader>tt :TestAll<CR>

    nnoremap <leader>s :P4edit "%"<CR>:AsyncRun -silent fb sort_includes %:p<CR>
endif

augroup ASYNCRUN
    autocmd FileType qf setlocal wincolor=QuickFixBackground
    autocmd FileType qf setlocal nonumber
    autocmd FileType qf setlocal norelativenumber
    autocmd FileType qf setlocal fillchars=eob:\ 

    if has("unix")
        autocmd BufWritePost *.c Make test NO_COLOR=1
    endif
augroup END
