" Keep cursorline visible only in the focused window.
function! s:focus_cursorline() abort
  let l:current = win_getid()

  for l:win in range(1, winnr('$'))
    execute l:win . 'wincmd w'
    setlocal nocursorline
  endfor

  call win_gotoid(l:current)
  setlocal cursorline
endfunction

augroup active_split_cursorline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call s:focus_cursorline()
  autocmd WinLeave * setlocal nocursorline
augroup END
