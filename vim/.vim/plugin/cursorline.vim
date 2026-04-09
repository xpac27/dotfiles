" Keep cursorline visible only in the focused window.
function! s:focus_cursorline() abort
  let l:current = win_getid()

  for l:info in getwininfo()
    call setwinvar(l:info.winid, '&cursorline', 0)
  endfor

  call setwinvar(l:current, '&cursorline', 1)
endfunction

augroup active_split_cursorline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call s:focus_cursorline()
augroup END
