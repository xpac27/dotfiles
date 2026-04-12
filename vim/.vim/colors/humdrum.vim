" Humdrum: vim-monotone's default look plus local overrides, flattened.
" Base highlight choices derive from Lokaltog/vim-monotone (MIT).

set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'humdrum'

if !exists('g:humdrum_emphasize_comments')
  let g:humdrum_emphasize_comments = 0
endif
if !exists('g:humdrum_emphasize_whitespace')
  let g:humdrum_emphasize_whitespace = 0
endif

" Palette. Hex values live here; highlight groups refer to these names.
let s:colors = {
      \ 'none': 'NONE',
      \ 'normal': '#d2cfcf',
      \ 'dark_0': '#393636',
      \ 'dark_1': '#222020',
      \ 'dark_2': '#171616',
      \ 'dark_3': '#121111',
      \ 'bright_0': '#5e5959',
      \ 'bright_1': '#787271',
      \ 'bright_2': '#9c9695',
      \ 'hl_1': '#f54646',
      \ 'hl_2': '#f5ac46',
      \ 'hl_3': '#46bbf5',
      \ 'eob': '#723030',
      \ 'nontext': '#9b4a3a',
      \ 'white': '#ffffff',
      \ 'black': '#000000',
      \ 'gray_1': '#1a1a1a',
      \ 'gray_1b': '#222222',
      \ 'gray_2': '#2a2a2a',
      \ 'gray_3': '#333333',
      \ 'gray_4': '#444444',
      \ 'gray_5': '#666666',
      \ 'gray_6': '#777777',
      \ 'gray_7': '#999999',
      \ 'gray_8': '#cccccc',
      \ 'gray_9': '#d7d7d7',
      \ 'gray_10': '#dddddd',
      \ 'red': '#ff4444',
      \ 'red_soft': '#ff9999',
      \ 'red_bg': '#221111',
      \ 'orange': '#dd9922',
      \ 'orange_soft': '#ffcc99',
      \ 'yellow': '#eeee99',
      \ 'yellow_soft': '#ffffcc',
      \ 'yellow_bg': '#222211',
      \ 'green': '#22dd22',
      \ 'green_soft': '#99ff99',
      \ 'green_bg': '#112211',
      \ 'cyan': '#99ffff',
      \ 'cyan_bg': '#112222',
      \ 'blue': '#99ccff',
      \ 'violet': '#9999ff',
      \ 'violet_soft': '#eeeeff',
      \ 'violet_bg': '#111122',
      \ 'violet_sel': '#333344',
      \ 'diff_add': '#88aa77',
      \ 'diff_delete': '#aa7766',
      \ 'diff_change': '#7788aa',
      \ 'ale_info': '#00afff',
      \ }

function! s:c(name) abort
  return get(s:colors, a:name, a:name)
endfunction

function! s:hi(group, fg, bg, gui, ctermfg, ctermbg, cterm, ...) abort
  let l:cmd = 'highlight ' . a:group
  if a:fg !=# ''
    let l:cmd .= ' guifg=' . s:c(a:fg)
  endif
  if a:bg !=# ''
    let l:cmd .= ' guibg=' . s:c(a:bg)
  endif
  if a:gui !=# ''
    let l:cmd .= ' gui=' . a:gui
  endif
  if a:ctermfg !=# ''
    let l:cmd .= ' ctermfg=' . a:ctermfg
  endif
  if a:ctermbg !=# ''
    let l:cmd .= ' ctermbg=' . a:ctermbg
  endif
  if a:cterm !=# ''
    let l:cmd .= ' cterm=' . a:cterm
  endif
  if a:0 && a:1 !=# ''
    let l:cmd .= ' guisp=' . s:c(a:1)
  endif
  execute l:cmd
endfunction

function! s:link(from, to) abort
  execute 'highlight! link ' . a:from . ' ' . a:to
endfunction

function! s:clear(group) abort
  execute 'highlight clear ' . a:group
endfunction

" Core editor chrome.
call s:hi('Normal', 'normal', 'dark_3', 'NONE', '252', '233', 'NONE')
call s:hi('Visual', 'dark_3', 'normal', 'NONE', '16', '248', 'NONE')
call s:hi('ColorColumn', 'NONE', 'dark_2', 'NONE', 'NONE', '234', 'NONE')
call s:hi('CursorLine', 'NONE', 'dark_1', 'NONE', 'NONE', '234', 'NONE')
call s:hi('CursorLineNr', 'bright_2', 'dark_1', 'NONE', 'NONE', '235', 'NONE')
call s:hi('LineNr', 'bright_0', 'NONE', 'NONE', '240', 'NONE', 'NONE')
call s:hi('VertSplit', 'gray_2', 'NONE', 'NONE', '240', 'NONE', 'NONE')
call s:hi('Folded', 'normal', 'dark_1', 'italic', '252', '235', 'italic')
call s:hi('WildMenu', 'dark_3', 'normal', 'NONE', '16', '248', 'NONE')
call s:hi('EndOfBuffer', 'eob', 'NONE', 'NONE', '95', 'NONE', 'NONE')
call s:hi('NonText', 'nontext', 'NONE', 'NONE', '95', 'NONE', 'NONE')
call s:hi('SpecialKey', 'red_soft', 'NONE', 'bold', 'NONE', 'NONE', 'bold')
call s:clear('FoldColumn')
call s:clear('SignColumn')

" Cursors.
call s:hi('Cursor', 'bg', 'hl_1', 'NONE', 'NONE', '203', 'NONE')
call s:hi('CursorI', '', 'white', '', '', '255', '')
call s:hi('CursorR', '', 'hl_2', '', '', '203', '')
call s:hi('CursorO', '', 'hl_3', '', '', '39', '')

" Search and matching.
call s:hi('Search', 'dark_3', 'hl_2', 'bold', '16', '214', 'bold')
call s:hi('IncSearch', 'dark_3', 'hl_2', 'bold,reverse', '16', '214', 'bold,reverse')
call s:hi('MatchParen', 'gray_9', 'gray_4', 'NONE', '16', '214', 'bold')
call s:link('ParenMatch', 'MatchParen')
call s:hi('CurrentWord', '', 'gray_4', '', '', '', '')

" Statusline and tabline.
call s:hi('StatusLine', 'gray_2', 'gray_2', 'underline', '248', 'NONE', 'underline')
call s:hi('StatusLineNC', 'gray_2', 'gray_2', 'underline', '240', 'NONE', 'underline')
call s:hi('TabLine', 'bright_0', 'NONE', 'NONE', '240', 'NONE', 'NONE')
call s:hi('TabLineFill', 'bright_0', 'NONE', 'NONE', '240', 'NONE', 'NONE')
call s:hi('TabLineSel', 'bright_2', 'NONE', 'bold', '248', 'NONE', 'bold')

" Popup menu.
call s:hi('Pmenu', 'violet', 'violet_bg', 'NONE', '246', '235', 'NONE')
call s:hi('PmenuSel', 'violet_soft', 'violet_sel', 'NONE', '252', '235', 'NONE')
call s:hi('PmenuSbar', 'NONE', 'violet_sel', 'NONE', 'NONE', '235', 'NONE')
call s:hi('PmenuThumb', 'NONE', 'violet', 'NONE', 'NONE', '235', 'NONE')

" Messages and diagnostics.
call s:hi('Error', 'red_soft', 'NONE', 'bold', '203', 'NONE', 'undercurl')
call s:hi('Warning', 'yellow', 'NONE', 'NONE', '214', 'NONE', 'undercurl')
call s:hi('Success', 'green_soft', 'NONE', '', '', '', 'undercurl')
call s:hi('ErrorMsg', 'red', 'red_bg', 'bold', '203', 'NONE', 'italic')
call s:hi('WarningMsg', 'orange', 'yellow_bg', 'bold', '214', 'NONE', 'italic')
call s:hi('SuccessMsg', 'green', 'green_bg', '', '', '', 'italic')
call s:hi('InfoMsg', 'cyan', 'cyan_bg', '', '', '', 'italic')
call s:hi('NoteMsg', 'yellow_soft', 'yellow_bg', '', '', '', '')
call s:hi('MoreMsg', 'hl_3', 'NONE', 'bold', '153', 'NONE', 'bold')

" Syntax groups.
call s:hi('Comment', g:humdrum_emphasize_comments ? 'hl_2' : 'bright_1', 'NONE', 'italic', '243', 'NONE', 'italic')
call s:hi('String', 'bright_2', 'NONE', 'NONE', '247', 'NONE', 'NONE')
call s:hi('Todo', 'hl_2', 'NONE', 'bold,italic', '214', 'NONE', 'bold,italic')
call s:hi('Function', 'NONE', 'NONE', 'italic', 'NONE', 'NONE', 'italic')
call s:hi('Identifier', 'NONE', 'NONE', 'italic', 'NONE', 'NONE', 'italic')
call s:hi('Include', 'gray_5', 'NONE', 'italic', 'NONE', 'NONE', 'italic')
call s:hi('Keyword', 'NONE', 'NONE', 'bold', 'NONE', 'NONE', 'bold')
call s:hi('Question', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE')
call s:hi('Statement', 'NONE', 'NONE', 'bold', 'NONE', 'NONE', 'bold')
call s:hi('Type', 'gray_10', 'NONE', 'bold', 'NONE', 'NONE', 'bold')
call s:hi('Underlined', 'NONE', 'NONE', 'underline', 'NONE', 'NONE', 'underline')
call s:hi('Title', 'NONE', 'NONE', 'bold', 'NONE', 'NONE', 'bold')
if g:humdrum_emphasize_whitespace
  call s:hi('Whitespace', 'hl_1', 'NONE', 'bold', '203', 'NONE', 'bold')
else
  call s:hi('Whitespace', 'dark_0', 'NONE', 'NONE', '236', 'NONE', 'NONE')
endif
for s:group in ['Conceal', 'Constant', 'Define', 'Directory', 'Label', 'Number', 'Operator', 'PreProc', 'Special', 'Noise']
  call s:clear(s:group)
endfor

" Diffs.
call s:hi('DiffAdd', 'diff_add', 'NONE', 'NONE', '107', 'NONE', 'NONE')
call s:hi('DiffDelete', 'diff_delete', 'NONE', 'NONE', '137', 'NONE', 'NONE')
call s:hi('DiffChange', 'diff_change', 'NONE', 'NONE', '67', 'NONE', 'NONE')
call s:hi('DiffText', 'diff_change', 'NONE', 'underline', '67', 'NONE', 'underline')

" Quickfix and compiler output.
call s:hi('QuickFixLine', '', 'gray_3', '', '', '', '')
call s:link('QuickFixLine', 'CursorLine')
call s:hi('QFNormal', '', 'gray_1b', '', '', '', '')
call s:hi('QFEndOfBuffer', 'gray_1b', '', '', '', '', '')
call s:hi('QuickFixBackground', 'gray_5', 'gray_3', '', '', '', '')
call s:hi('qfError', 'red', 'red_bg', '', '', '', '')
call s:hi('qfSeparator', 'gray_2', '', '', '', '', '')
call s:hi('qfLineNr', 'gray_9', '', '', '', '', '')
call s:hi('qfFileName', 'gray_9', '', '', '', '', '')
call s:link('TestFailed', 'ErrorMsg')
call s:link('GTestOk', 'Success')
call s:link('GTestPassed', 'Success')
call s:link('GTestFailed', 'ErrorMsg')
call s:link('GTestError', 'ErrorMsg')
call s:link('GTestNote', 'NoteMsg')
call s:link('ITestError', 'Error')
call s:link('ITestWarning', 'Warning')
call s:link('ITestSuccess', 'Success')
call s:link('MSBuildError', 'ErrorMsg')
call s:link('MSBuildWarning', 'WarningMsg')
call s:link('MSBuildInfo', 'InfoMsg')
call s:link('MSBuildNote', 'NoteMsg')

" Spelling and motion/highlight plugins.
call s:hi('ALEError', '', '', 'undercurl', '203', '', 'underline', 'red')
call s:hi('ALEWarning', '', '', 'undercurl', '214', '', 'underline', 'orange')
call s:hi('ALEErrorSign', 'red', '', '', '203', '', '')
call s:hi('ALEWarningSign', 'orange', '', '', '214', '', '')
for s:group in ['SpellBad', 'SpellCap', 'SpellRare']
  call s:clear(s:group)
  call s:link(s:group, 'ALEError')
endfor
call s:clear('SpellLocal')
call s:link('SpellLocal', 'ALEWarning')
call s:link('CursorWordHighlight', 'Underlined')
call s:hi('Sneak', 'black', 'hl_3', 'NONE', '16', '153', 'NONE')
call s:hi('SneakLabel', 'black', 'hl_3', 'bold', '16', '153', 'bold')
call s:hi('SneakLabelMask', 'hl_3', 'hl_3', 'NONE', '153', '153', 'NONE')
call s:hi('QuickScopePrimary', '', '', 'underline', '', '', '', 'red')
call s:hi('QuickScopeSecondary', '', '', 'underline', '', '', '', 'red')
call s:link('HighlightedyankRegion', 'Warning')

" Completion, Coc, and LSP.
call s:hi('CocHighlightText', '', 'gray_4', '', '', '', '')
call s:hi('CocHighlightRead', '', 'gray_4', '', '', '', '')
call s:hi('CocHighlightWrite', '', 'gray_4', '', '', '', '')
call s:hi('CocFloating', 'violet', 'violet_bg', '', '', '', '')
call s:hi('CocErrorHighlight', 'red_soft', 'red_bg', 'undercurl', '203', '', 'undercurl', 'red')
call s:hi('CocWarningHighlight', 'yellow', 'yellow_bg', 'undercurl', '214', '', 'undercurl', 'orange')
call s:hi('CocInfoHighlight', 'cyan', 'cyan_bg', 'undercurl', '153', '', 'undercurl', 'ale_info')
call s:hi('CocHintHighlight', 'yellow_soft', 'yellow_bg', 'undercurl', '153', '', 'undercurl', 'ale_info')
call s:hi('CocErrorSign', 'red', '', '', '203', '', '')
call s:hi('CocWarningSign', 'orange', '', '', '214', '', '')
call s:hi('CocInfoSign', 'ale_info', '', '', '153', '', '')
call s:hi('CocHintSign', 'ale_info', '', '', '153', '', '')
call s:hi('CocErrorVirtualText', 'red', 'red_bg', '', '', '', 'italic')
call s:hi('CocWarningVirtualText', 'orange', 'yellow_bg', '', '', '', 'italic')
call s:hi('CocInfoVirtualText', 'cyan', 'cyan_bg', '', '', '', 'italic')
call s:hi('CocHintVirtualText', 'yellow_soft', 'yellow_bg', '', '', '', 'italic')
call s:hi('CocErrorFloat', 'violet', 'violet_bg', '', '', '', 'italic')
call s:hi('CocWarningFloat', 'violet', 'violet_bg', '', '', '', 'italic')
call s:hi('CocInfoFloat', 'violet', 'violet_bg', '', '', '', 'italic')
call s:hi('CocHintFloat', 'violet', 'violet_bg', '', '', '', 'italic')
call s:hi('CocFloatBorder', 'violet', 'violet_bg', '', '', '', '')
call s:link('LspSemanticType', 'Type')
call s:link('LspSemanticClass', 'Type')
call s:link('LspSemanticEnum', 'Type')
call s:link('LspSemanticInterface', 'Type')
call s:link('LspSemanticStruct', 'Type')
call s:link('LspSemanticTypeParameter', 'Type')
call s:link('LspSemanticEvents', 'Label')
call s:link('LspSemanticFunction', 'Function')
call s:link('LspSemanticKeyword', 'Keyword')
call s:link('LspSemanticModifier', 'Operator')
call s:link('LspSemanticComment', 'Comment')
call s:link('LspSemanticNumber', 'Number')
call s:link('LspSemanticOperator', 'Operator')
call s:link('LspInformationHighlight', 'NoteMsg')
call s:link('LspInformationText', 'InfoMsg')

" FZF.
call s:hi('FzfBackground', 'gray_9', 'violet_bg', '', '', '', '')
call s:hi('FzfSelected', 'gray_10', 'yellow_bg', '', '', '', '')
call s:hi('FzfMatch', 'orange', 'NONE', 'bold', '', '', 'bold')
call s:hi('FzfMatchSelected', 'yellow', 'yellow_bg', 'bold', '', '', 'bold')
call s:hi('FzfMarker', 'yellow', 'NONE', '', '', '', '')

" Markdown.
call s:hi('mkdHeading', 'yellow', '', 'bold', '', '', 'bold')
call s:hi('htmlH1', 'yellow', '', 'bold', '', '', 'bold')
call s:hi('htmlH2', 'gray_10', '', 'bold', '', '', 'bold')
call s:hi('htmlH3', 'cyan', '', 'bold', '', '', 'bold')
call s:hi('htmlH4', 'blue', '', 'bold', '', '', 'bold')
call s:hi('htmlH5', 'gray_8', '', 'bold', '', '', 'bold')
call s:hi('htmlH6', 'gray_7', '', 'bold', '', '', 'bold')
call s:hi('mkdCode', 'green_soft', 'gray_1', '', '', '', '')
call s:hi('mkdCodeDelimiter', 'gray_5', 'gray_1', '', '', '', '')
call s:hi('mkdLink', 'blue', '', 'underline', '', '', 'underline')
call s:hi('mkdInlineURL', 'cyan', '', 'underline', '', '', 'underline')
call s:hi('mkdURL', 'cyan', '', '', '', '', '')
call s:hi('mkdLinkDefTarget', 'cyan', '', '', '', '', '')
call s:hi('mkdDelimiter', 'gray_5', '', '', '', '', '')
call s:hi('mkdBlockquote', 'gray_7', '', 'italic', '', '', 'italic')
call s:hi('mkdListItem', 'orange', '', 'bold', '', '', 'bold')
call s:hi('mkdListItemCheckbox', 'yellow', '', 'bold', '', '', 'bold')
call s:hi('mkdRule', 'gray_4', '', '', '', '', '')
call s:hi('mkdMath', 'orange_soft', '', '', '', '', '')
call s:hi('mkdStrike', 'gray_6', '', 'strikethrough', '', '', 'strikethrough')
call s:hi('mkdFootnote', 'gray_8', '', '', '', '', '')
call s:hi('mkdFootnotes', 'gray_8', '', '', '', '', '')
call s:hi('markdownHeadingDelimiter', 'gray_5', '', '', '', '', '')
call s:hi('markdownCode', 'green_soft', 'gray_1', '', '', '', '')
call s:hi('markdownCodeDelimiter', 'gray_5', 'gray_1', '', '', '', '')
call s:hi('markdownLinkText', 'blue', '', 'underline', '', '', 'underline')
call s:hi('markdownAutomaticLink', 'cyan', '', 'underline', '', '', 'underline')
call s:hi('markdownUrl', 'cyan', '', '', '', '', '')
call s:hi('markdownUrlDelimiter', 'gray_5', '', '', '', '', '')
call s:hi('markdownUrlTitle', 'gray_8', '', '', '', '', '')
call s:hi('markdownBlockquote', 'gray_7', '', 'italic', '', '', 'italic')
call s:hi('markdownListMarker', 'orange', '', 'bold', '', '', 'bold')
call s:hi('markdownRule', 'gray_4', '', '', '', '', '')
call s:hi('markdownFootnote', 'gray_8', '', '', '', '', '')
call s:hi('markdownFootnoteDefinition', 'gray_8', '', '', '', '', '')
call s:hi('markdownItalic', '', '', 'italic', '', '', 'italic')
call s:hi('markdownBold', '', '', 'bold', '', '', 'bold')
call s:hi('markdownBoldItalic', '', '', 'bold,italic', '', '', 'bold,italic')
call s:hi('markdownStrike', 'gray_6', '', 'strikethrough', '', '', 'strikethrough')

" Netrw and misc plugin groups.
call s:hi('netrwDir', 'gray_5', '', '', '', '', 'bold')
call s:hi('netrwPlain', 'gray_9', '', '', '', '', 'none')
call s:hi('netrwTreeBar', 'gray_5', '', '', '', '', '')
call s:link('netrwExe', 'netrwPlain')
call s:hi('CopilotSuggestion', 'violet', 'violet_bg', '', '', '', '')

if exists('g:lightline')
  let g:lightline.colorscheme = 'humdrum'
endif
