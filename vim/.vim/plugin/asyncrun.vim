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

    command! Ninja execute 'AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb build ' . shellescape(expand('%:p'))
    command! NinjaBO AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb build Extension.BattlefieldOnline_all
    command! NinjaAll AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb build all

    command! Test execute 'AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb test ' . shellescape(expand('%:p') . ':' . line('.')) . ' --include-slow'
    command! TestAll execute 'AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb test ' . shellescape(expand('%:p'))
    command! IntTest AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb test integration
    command! UnitTest AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb test unit --record-timings
    command! UnitTestFast AsyncRun -strip ruby E:\Gitlab\scripts\compile_v2.rb test unit

    nnoremap <silent> <leader>m  <cmd>Ninja<CR>
    nnoremap <silent> <leader>mm <cmd>NinjaAll<CR>
    nnoremap <silent> <leader>t  <cmd>Test<CR>
    nnoremap <silent> <leader>tt <cmd>TestAll<CR>

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
