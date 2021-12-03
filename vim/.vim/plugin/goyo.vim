function! s:goyo_enter()
    hi! link StatusLine GruvBoxBg0
    hi! link StatusLineNC GruvBoxBg0
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap Y :Goyo<CR>

