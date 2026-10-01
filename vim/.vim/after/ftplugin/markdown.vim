setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=4
setlocal formatoptions-=r
setlocal formatoptions-=o
" setlocal spell
setlocal wrap
setlocal linebreak
setlocal textwidth=0
setlocal listchars=trail:·
setlocal conceallevel=3
setlocal concealcursor=
setlocal foldmethod=manual
setlocal nofoldenable

" Align the displayed cells of pipe tables without changing their Markdown.
if has('textprop') && exists('*prop_add')
  let s:table_padding_type = 'markdown_table_padding'
  if empty(prop_type_get(s:table_padding_type, {'bufnr': bufnr('%')}))
    call prop_type_add(s:table_padding_type, {'bufnr': bufnr('%')})
  endif

  " Return the byte columns of actual pipe delimiters, ignoring escaped pipes.
  function! s:TablePipes(line) abort
    let l:pipes = []
    let l:backslashes = 0
    for l:i in range(strchars(a:line))
      let l:char = strcharpart(a:line, l:i, 1)
      if l:char ==# '\'
        let l:backslashes += 1
      else
        if l:char ==# '|' && l:backslashes % 2 == 0
          call add(l:pipes, byteidx(a:line, l:i) + 1)
        endif
        let l:backslashes = 0
      endif
    endfor
    return l:pipes
  endfunction

  function! s:TableCells(lnum) abort
    let l:line = getline(a:lnum)
    if stridx(l:line, '|') < 0
      return []
    endif
    let l:pipes = s:TablePipes(l:line)
    if empty(l:pipes)
      return []
    endif
    let l:left = l:pipes[0] == match(l:line, '\S') + 1
    let l:right = l:pipes[-1] == strlen(substitute(l:line, '\s*$', '', ''))
    let l:boundaries = [1] + l:pipes + [strlen(l:line) + 1]
    let l:cells = []
    for l:i in range(len(l:boundaries) - 1)
      if (l:i == 0 && l:left) || (l:i == len(l:boundaries) - 2 && l:right)
        continue
      endif
      call add(l:cells, {
            \ 'start': l:boundaries[l:i] + (l:i > 0 ? 1 : 0),
            \ 'end': l:boundaries[l:i + 1],
            \ 'pipe': l:i + 1 < len(l:boundaries) - 1 ? l:boundaries[l:i + 1] : 0,
            \ })
    endfor
    return l:cells
  endfunction

  function! s:IsCodeLine(lnum) abort
    let l:col = match(getline(a:lnum), '\S') + 1
    for l:id in synstack(a:lnum, max([1, l:col]))
      if synIDattr(l:id, 'name') =~# '^\%(mkdCode\|markdownCode\)'
        return 1
      endif
    endfor
    return 0
  endfunction

  function! s:IsSeparator(lnum, cells) abort
    if empty(a:cells)
      return 0
    endif
    let l:line = getline(a:lnum)
    for l:cell in a:cells
      if trim(strpart(l:line, l:cell.start - 1, l:cell.end - l:cell.start)) !~# '^:\?[-]\+:\?$'
        return 0
      endif
    endfor
    return 1
  endfunction

  " synconcealed() supplies the replacement actually used by the syntax file.
  function! s:VisibleText(lnum, cell) abort
    let l:line = getline(a:lnum)
    let l:visible = ''
    let l:last_conceal = 0
    let l:start_char = charidx(l:line, a:cell.start - 1)
    let l:end_char = charidx(l:line, a:cell.end - 1)
    for l:i in range(l:start_char, l:end_char - 1)
      let l:col = byteidx(l:line, l:i) + 1
      let l:conceal = synconcealed(a:lnum, l:col)
      if l:conceal[0]
        if l:last_conceal != l:conceal[2]
          let l:visible .= l:conceal[1]
        endif
        let l:last_conceal = l:conceal[2]
      else
        let l:visible .= strcharpart(l:line, l:i, 1)
        let l:last_conceal = 0
      endif
    endfor
    return l:visible
  endfunction

  function! s:VisibleWidth(lnum, cell) abort
    return strdisplaywidth(s:VisibleText(a:lnum, a:cell))
  endfunction

  function! s:BuildTableCache() abort
    let b:markdown_table_tables = []
    let b:markdown_table_rows = {}
    let l:last = line('$')
    let b:markdown_table_line_count = l:last
    let l:lnum = 2
    while l:lnum <= l:last
      if getline(l:lnum) !~# '^\s*[|: -]\+\s*$' || s:IsCodeLine(l:lnum)
        let l:lnum += 1
        continue
      endif
      let l:separator = s:TableCells(l:lnum)
      let l:header = s:TableCells(l:lnum - 1)
      if !s:IsSeparator(l:lnum, l:separator) || len(l:header) != len(l:separator)
        let l:lnum += 1
        continue
      endif
      let l:rows = [l:lnum - 1, l:lnum]
      let l:next = l:lnum + 1
      while l:next <= l:last && !s:IsCodeLine(l:next) && len(s:TableCells(l:next)) == len(l:separator)
        call add(l:rows, l:next)
        let l:next += 1
      endwhile
      let l:cells_by_row = {}
      let l:table_index = len(b:markdown_table_tables)
      for l:row in l:rows
        let b:markdown_table_rows[l:row] = l:table_index
        let l:cells_by_row[l:row] = s:TableCells(l:row)
        for l:i in range(len(l:separator))
          let l:cell = l:cells_by_row[l:row][l:i]
          let l:cell.hidden_width = s:VisibleWidth(l:row, l:cell)
          let l:cell.raw_width = strdisplaywidth(strpart(getline(l:row), l:cell.start - 1, l:cell.end - l:cell.start))
        endfor
      endfor
      call add(b:markdown_table_tables, {'rows': l:rows, 'cells': l:cells_by_row, 'columns': len(l:separator)})
      let l:lnum = l:next
    endwhile
    let b:markdown_table_tick = b:changedtick
  endfunction

  " During insertion, recalculate only the changed row of an existing table.
  function! s:UpdateChangedTableRow() abort
    let l:row = line('.')
    if get(b:, 'markdown_table_line_count', -1) != line('$')
          \ || !has_key(get(b:, 'markdown_table_rows', {}), l:row)
          \ || s:IsCodeLine(l:row)
      return 0
    endif
    let l:table = b:markdown_table_tables[b:markdown_table_rows[l:row]]
    if l:row == l:table.rows[1]
      return 0
    endif
    let l:cells = s:TableCells(l:row)
    if len(l:cells) != l:table.columns || s:IsSeparator(l:row, l:cells)
      return 0
    endif
    for l:cell in l:cells
      let l:cell.hidden_width = s:VisibleWidth(l:row, l:cell)
      let l:cell.raw_width = strdisplaywidth(strpart(getline(l:row), l:cell.start - 1, l:cell.end - l:cell.start))
    endfor
    let l:table.cells[l:row] = l:cells
    let b:markdown_table_tick = b:changedtick
    return 1
  endfunction

  function! s:ApplyTablePadding() abort
    call prop_remove({'type': s:table_padding_type, 'bufnr': bufnr('%'), 'all': 1})
    let l:cursor_mode = mode() =~# '^[vV]' || mode() ==# "\<C-v>" ? 'v' : mode()[0]
    let l:reveal_cursor = &conceallevel > 0 && stridx(&concealcursor, l:cursor_mode) < 0
    for l:table in b:markdown_table_tables
      let l:widths = repeat([0], l:table.columns)
      for l:row in l:table.rows
        for l:i in range(l:table.columns)
          let l:cell = l:table.cells[l:row][l:i]
          let l:cell.width = l:reveal_cursor && l:row == line('.') ? l:cell.raw_width : l:cell.hidden_width
          let l:widths[l:i] = max([l:widths[l:i], l:cell.width])
        endfor
      endfor
      let l:table_width = 3 * l:table.columns + 1
      for l:width in l:widths
        let l:table_width += l:width
      endfor
      let l:text_width = winwidth(0) - getwininfo(win_getid())[0].textoff
      if l:table_width > l:text_width
        continue
      endif
      for l:row in l:table.rows
        for l:i in range(l:table.columns)
          let l:cell = l:table.cells[l:row][l:i]
          let l:padding = l:widths[l:i] - l:cell.width
          if l:cell.pipe && l:padding > 0
            " Plain spaces disappear after some concealed regions in Vim.
            call prop_add(l:row, l:cell.pipe, {'type': s:table_padding_type, 'text': repeat(nr2char(0xa0), l:padding)})
          endif
        endfor
      endfor
    endfor
    let b:markdown_table_cursor = line('.')
    let b:markdown_table_mode = l:cursor_mode
  endfunction

  function! s:RefreshTablePadding() abort
    if &filetype ==# 'markdown'
      call s:BuildTableCache()
      call s:ApplyTablePadding()
    endif
  endfunction

  function! s:MaybeRefreshTablePadding() abort
    let l:cursor = line('.')
    let l:mode = mode() =~# '^[vV]' || mode() ==# "\<C-v>" ? 'v' : mode()[0]
    if get(b:, 'markdown_table_tick', -1) == b:changedtick
          \ && get(b:, 'markdown_table_cursor', -1) == l:cursor
          \ && get(b:, 'markdown_table_mode', '') ==# l:mode
      return
    endif
    if get(b:, 'markdown_table_tick', -1) == b:changedtick
          \ && !has_key(get(b:, 'markdown_table_rows', {}), l:cursor)
          \ && !has_key(get(b:, 'markdown_table_rows', {}), get(b:, 'markdown_table_cursor', -1))
      let b:markdown_table_cursor = l:cursor
      let b:markdown_table_mode = l:mode
      return
    endif
    if get(b:, 'markdown_table_tick', -1) != b:changedtick
      if !s:UpdateChangedTableRow()
        if mode()[0] ==# 'i'
          return
        endif
        call s:BuildTableCache()
      endif
    endif
    call s:ApplyTablePadding()
  endfunction

  function! s:ClearTablePadding() abort
    call prop_remove({'type': s:table_padding_type, 'bufnr': bufnr('%'), 'all': 1})
    augroup markdown_table_padding
      autocmd! * <buffer>
    augroup END
    if exists(':MarkdownTableRefresh')
      delcommand MarkdownTableRefresh
    endif
  endfunction

  augroup markdown_table_padding
    autocmd! * <buffer>
    autocmd BufEnter,CursorMoved,CursorMovedI,InsertEnter,TextChangedI <buffer> call <SID>MaybeRefreshTablePadding()
    autocmd InsertLeave,TextChanged <buffer> call <SID>RefreshTablePadding()
  augroup END
  command! -buffer MarkdownTableRefresh call <SID>RefreshTablePadding()
  let b:undo_ftplugin = get(b:, 'undo_ftplugin', '') . '|call ' . expand('<SID>') . 'ClearTablePadding()'
  call s:RefreshTablePadding()
endif
