vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.o.background = 'dark'
vim.g.colors_name = 'monotone'

local p = {
  bg0 = '#111111',
  bg1 = '#191919',
  bg2 = '#222222',
  bg3 = '#333333',
  bg4 = '#444444',
  fg0 = '#d7d7d7',
  fg1 = '#bcbcbc',
  fg2 = '#9e9e9e',
  dim0 = '#666666',
  dim1 = '#4e4e4e',
  dim2 = '#3a3a3a',
  err = '#ff9999',
  err_msg_fg = '#ff4444',
  err_msg_bg = '#221111',
  warn = '#eeee99',
  warn_msg_fg = '#dd9922',
  warn_msg_bg = '#222211',
  ok = '#99ff99',
  ok_bg = '#112211',
  info = '#99ffff',
  info_bg = '#112222',
  hint = '#9999ff',
  hint_bg = '#111122',
}

local set = vim.api.nvim_set_hl

local function hi(group, opts)
  set(0, group, opts)
end

hi('Normal', { fg = p.fg0, bg = p.bg0 })
hi('NormalFloat', { fg = p.fg0, bg = p.bg1 })
hi('FloatBorder', { fg = p.dim0, bg = p.bg1 })
hi('FloatTitle', { fg = p.fg0, bg = p.bg1, bold = true })
hi('Visual', { fg = p.bg0, bg = p.fg2 })

hi('Cursor', { bg = p.err })
hi('CursorLine', { bg = p.bg1 })
hi('CursorColumn', { bg = p.bg1 })
hi('CursorLineNr', { fg = p.fg0, bg = p.bg1 })
hi('ColorColumn', { bg = p.bg2 })
hi('LineNr', { fg = p.dim1 })
hi('SignColumn', { bg = p.bg0 })
hi('FoldColumn', { bg = p.bg0 })
hi('Folded', { fg = p.fg1, bg = p.bg1, italic = true })
hi('EndOfBuffer', { fg = p.bg2 })
hi('NonText', { fg = p.dim1 })
hi('Whitespace', { fg = p.dim2 })
hi('SpecialKey', { fg = p.err })
hi('VertSplit', { fg = p.dim1 })
hi('WinSeparator', { fg = p.dim1 })

hi('StatusLine', { fg = p.fg0, bg = p.bg0, underline = true })
hi('StatusLineNC', { fg = p.bg0, bg = p.bg0, underline = true })
hi('TabLine', { fg = p.dim1, bg = p.bg0 })
hi('TabLineFill', { fg = p.dim1, bg = p.bg0 })
hi('TabLineSel', { fg = p.fg0, bg = p.bg0, bold = true })

hi('Pmenu', { fg = p.hint, bg = p.hint_bg })
hi('PmenuSel', { fg = '#eeeeff', bg = p.bg3 })
hi('PmenuSbar', { bg = p.bg3 })
hi('PmenuThumb', { bg = p.hint })

hi('Search', { fg = p.bg0, bg = p.warn, bold = true })
hi('IncSearch', { fg = p.bg0, bg = p.warn, bold = true, reverse = true })
hi('MatchParen', { fg = p.fg0, bg = p.bg4, bold = true })
hi('WildMenu', { fg = p.bg0, bg = p.fg2 })
hi('Directory', { fg = p.dim0 })
hi('Title', { bold = true })
hi('Underlined', { underline = true })

hi('Comment', { fg = p.fg2, italic = true })
hi('String', { fg = p.fg0 })
hi('Character', { fg = p.fg0 })
hi('Number', {})
hi('Boolean', {})
hi('Float', {})
hi('Constant', {})
hi('Identifier', { italic = true })
hi('Function', { italic = true })
hi('Statement', { bold = true })
hi('Conditional', { bold = true })
hi('Repeat', { bold = true })
hi('Label', {})
hi('Operator', {})
hi('Keyword', { bold = true })
hi('Exception', { bold = true })
hi('PreProc', {})
hi('Include', { fg = p.dim0, italic = true })
hi('Define', {})
hi('Macro', {})
hi('PreCondit', {})
hi('Type', { fg = '#dddddd', bold = true })
hi('StorageClass', { bold = true })
hi('Structure', { bold = true })
hi('Typedef', { bold = true })
hi('Special', {})
hi('Delimiter', {})
hi('SpecialComment', {})
hi('Tag', {})
hi('Todo', { fg = p.warn_msg_fg, bold = true, italic = true })

hi('DiffAdd', { fg = '#88aa77' })
hi('DiffDelete', { fg = '#aa7766' })
hi('DiffChange', { fg = '#7788aa' })
hi('DiffText', { fg = '#7788aa', underline = true })

hi('Error', { fg = p.err, undercurl = true, sp = p.err_msg_fg })
hi('Warning', { fg = p.warn, undercurl = true, sp = p.warn_msg_fg })
hi('Success', { fg = p.ok, undercurl = true, sp = p.ok })
hi('ErrorMsg', { fg = p.err_msg_fg, bg = p.err_msg_bg, italic = true })
hi('WarningMsg', { fg = p.warn_msg_fg, bg = p.warn_msg_bg, italic = true })
hi('SuccessMsg', { fg = '#22dd22', bg = p.ok_bg, italic = true })
hi('MoreMsg', { fg = p.info, bold = true })
hi('InfoMsg', { fg = p.info, bg = p.info_bg, italic = true })
hi('Question', {})

hi('DiagnosticError', { fg = p.err_msg_fg })
hi('DiagnosticWarn', { fg = p.warn_msg_fg })
hi('DiagnosticInfo', { fg = p.info })
hi('DiagnosticHint', { fg = p.hint })
hi('DiagnosticOk', { fg = p.ok })
hi('DiagnosticSignError', { fg = p.err_msg_fg, bg = p.bg0 })
hi('DiagnosticSignWarn', { fg = p.warn_msg_fg, bg = p.bg0 })
hi('DiagnosticSignInfo', { fg = p.info, bg = p.bg0 })
hi('DiagnosticSignHint', { fg = p.hint, bg = p.bg0 })
hi('DiagnosticVirtualTextError', { fg = p.err_msg_fg, bg = p.err_msg_bg, italic = true })
hi('DiagnosticVirtualTextWarn', { fg = p.warn_msg_fg, bg = p.warn_msg_bg, italic = true })
hi('DiagnosticVirtualTextInfo', { fg = p.info, bg = p.info_bg, italic = true })
hi('DiagnosticVirtualTextHint', { fg = p.hint, bg = p.hint_bg, italic = true })
hi('DiagnosticUnderlineError', { undercurl = true, sp = p.err_msg_fg })
hi('DiagnosticUnderlineWarn', { undercurl = true, sp = p.warn_msg_fg })
hi('DiagnosticUnderlineInfo', { undercurl = true, sp = p.info })
hi('DiagnosticUnderlineHint', { undercurl = true, sp = p.hint })
hi('LspReferenceText', { bg = p.bg4 })
hi('LspReferenceRead', { bg = p.bg4 })
hi('LspReferenceWrite', { bg = p.bg4 })

hi('QuickFixLine', { link = 'CursorLine' })
hi('qfLineNr', { fg = p.fg0 })
hi('qfFileName', { fg = p.fg0 })
hi('qfError', { fg = p.err_msg_fg, bg = p.err_msg_bg })
hi('qfSeparator', { fg = '#2a2a2a' })

hi('netrwDir', { fg = p.dim0, bold = true })
hi('netrwPlain', { fg = p.fg0 })
hi('netrwTreeBar', { fg = p.dim0 })
hi('netrwExe', { link = 'netrwPlain' })

hi('@lsp.type.type', { link = 'Type' })
hi('@lsp.type.class', { link = 'Type' })
hi('@lsp.type.enum', { link = 'Type' })
hi('@lsp.type.interface', { link = 'Type' })
hi('@lsp.type.struct', { link = 'Type' })
hi('@lsp.type.typeParameter', { link = 'Type' })
hi('@lsp.type.function', { link = 'Function' })
hi('@lsp.type.keyword', { link = 'Keyword' })
hi('@lsp.type.operator', { link = 'Operator' })
hi('@lsp.type.comment', { link = 'Comment' })
hi('@lsp.type.number', { link = 'Number' })
hi('@lsp.mod.defaultLibrary', { link = 'Include' })

hi('BlinkCmpMenu', { link = 'Pmenu' })
hi('BlinkCmpMenuSelection', { link = 'PmenuSel' })
hi('BlinkCmpScrollBarThumb', { link = 'PmenuThumb' })
hi('BlinkCmpScrollBarGutter', { link = 'PmenuSbar' })
hi('BlinkCmpLabel', { fg = p.fg0 })
hi('BlinkCmpLabelDeprecated', { fg = p.dim0, strikethrough = true })
hi('BlinkCmpLabelMatch', { fg = p.hint, bold = true })
hi('BlinkCmpKind', { fg = p.fg2 })
hi('BlinkCmpSource', { fg = p.dim0 })

hi('LualineNormalA', { fg = p.bg0, bg = p.fg0 })
hi('LualineInsertA', { fg = p.bg0, bg = '#a8d7af' })
hi('LualineVisualA', { fg = p.bg0, bg = '#ffffff' })
hi('LualineReplaceA', { fg = p.bg0, bg = p.err })
hi('LualineInactiveA', { fg = p.fg2, bg = p.dim2 })
