" Keep copied text in an independent process: a Ctrl+Z-stopped Vim cannot
" answer Wayland clipboard requests, which can hang a terminal on paste.
" Use Vim's supported provider API (:help clipboard-providers), rather than
" overwriting the clipboard on suspension. wl-copy survives Vim suspension
" and exit. Reconsider when native Vim safely hands off clipboard ownership.
if !exists('v:clipproviders') || empty($WAYLAND_DISPLAY) || has('gui_running')
    finish
endif

function! s:available() abort
    return executable('wl-copy') && executable('wl-paste') && executable('timeout')
endfunction

let s:copied = {}

function! s:command(program, reg) abort
    return 'timeout 3s ' . a:program . (a:reg ==# '*' ? ' --primary' : '')
                \ . ' --type ' . shellescape('text/plain;charset=utf-8')
endfunction

function! s:warn(message) abort
    echohl WarningMsg
    echomsg a:message
    echohl None
endfunction

function! s:copy(reg, type, lines) abort
    let text = join(a:lines, "\n") . (a:type ==# 'V' ? "\n" : '')
    call system(s:command('wl-copy', a:reg), text)
    if v:shell_error
        call s:warn('Wayland clipboard copy failed or timed out')
        return
    endif
    " Plain text has no Vim register metadata. Preserve our own linewise and
    " blockwise types when the clipboard still contains exactly this text.
    let s:copied[a:reg] = {'text': text, 'type': a:type, 'lines': copy(a:lines)}
endfunction

function! s:paste(reg) abort
    let text = system(s:command('wl-paste --no-newline', a:reg))
    if v:shell_error
        call s:warn('Wayland clipboard read failed or timed out')
        return ['v', []]
    endif
    let previous = get(s:copied, a:reg, {})
    if !empty(previous) && previous.text ==# text
        return [previous.type, copy(previous.lines)]
    endif
    let lines = split(text, "\n", 1)
    if text =~# "\n$"
        call remove(lines, -1)
        return ['V', lines]
    endif
    return ['v', lines]
endfunction

let v:clipproviders['wl_clipboard'] = {
            \ 'available': function('s:available'),
            \ 'copy': {'+': function('s:copy'), '*': function('s:copy')},
            \ 'paste': {'+': function('s:paste'), '*': function('s:paste')},
            \ }
" Re-sourcing this file must not duplicate the provider in the option.
let &clipmethod = 'wl_clipboard,' . join(filter(split(&clipmethod, ','),
            \ 'v:val !=# "wl_clipboard"'), ',')
