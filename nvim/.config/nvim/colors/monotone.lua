vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.o.background = 'dark'
vim.g.colors_name = 'monotone'

-- Monotone is a deliberately small dark palette:
-- neutral grays do most of the work and a few soft accents are reserved for
-- diagnostics, completion, and search. The goal is to match the old Vim setup
-- without carrying over its runtime hue/contrast tweaking logic.
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

-- Core editor surfaces. Keep the background nearly black and let the foreground
-- do the contrast work rather than painting every group.
hi('Normal', { fg = p.fg0, bg = p.bg0 })
hi('NormalFloat', { fg = p.fg0, bg = p.bg1 })
hi('FloatBorder', { fg = p.dim0, bg = p.bg1 })
hi('FloatTitle', { fg = p.fg0, bg = p.bg1, bold = true })
hi('Visual', { fg = p.bg0, bg = p.fg2 })

-- Cursor and window chrome. These groups shape the "frame" of the editor:
-- line numbers, separators, folds, and the active line.
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

-- Statusline and tabline stay understated so diagnostics and code remain the
-- brightest things on screen.
hi('StatusLine', { fg = p.fg0, bg = p.bg0, underline = true })
hi('StatusLineNC', { fg = p.bg0, bg = p.bg0, underline = true })
hi('TabLine', { fg = p.dim1, bg = p.bg0 })
hi('TabLineFill', { fg = p.dim1, bg = p.bg0 })
hi('TabLineSel', { fg = p.fg0, bg = p.bg0, bold = true })

-- Completion menu: bluish foreground/background taken from the old custom Vim
-- overrides so the popup stands apart from the main buffer.
hi('Pmenu', { fg = p.hint, bg = p.hint_bg })
hi('PmenuSel', { fg = '#eeeeff', bg = p.bg3 })
hi('PmenuSbar', { bg = p.bg3 })
hi('PmenuThumb', { bg = p.hint })

-- Utility highlights for search, parenthesis matching, and other transient UI.
hi('Search', { fg = p.bg0, bg = p.warn, bold = true })
hi('IncSearch', { fg = p.bg0, bg = p.warn, bold = true, reverse = true })
hi('MatchParen', { fg = p.fg0, bg = p.bg4, bold = true })
hi('WildMenu', { fg = p.bg0, bg = p.fg2 })
hi('Directory', { fg = p.dim0 })
hi('Title', { bold = true })
hi('Underlined', { underline = true })

-- Syntax stays mostly monochrome. Only comments, includes, types, and TODOs
-- get distinct treatment, which keeps the overall look calm like the Vim theme.
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

-- Diff colors are intentionally muted: visible enough for review, but still in
-- character with the neutral theme.
hi('DiffAdd', { fg = '#88aa77' })
hi('DiffDelete', { fg = '#aa7766' })
hi('DiffChange', { fg = '#7788aa' })
hi('DiffText', { fg = '#7788aa', underline = true })
hi('MiniDiffSignAdd', { fg = '#88aa77' })
hi('MiniDiffSignChange', { fg = '#7788aa' })
hi('MiniDiffSignDelete', { fg = '#aa7766' })
hi('MiniDiffOverAdd', { fg = '#88aa77' })
hi('MiniDiffOverChange', { fg = '#7788aa' })
hi('MiniDiffOverDelete', { fg = '#aa7766' })
hi('MiniDiffOverChangeBuf', { fg = '#7788aa' })
hi('MiniDiffOverContext', { fg = p.dim0 })
hi('MiniDiffOverContextBuf', { fg = p.dim0 })

-- Message and diagnostic primitives. These are the semantic accent colors the
-- rest of the theme links back to.
hi('Error', { fg = p.err, underline = true, undercurl = true, sp = p.err_msg_fg })
hi('Warning', { fg = p.warn, underline = true, undercurl = true, sp = p.warn_msg_fg })
hi('Success', { fg = p.ok, underline = true, undercurl = true, sp = p.ok })
hi('ErrorMsg', { fg = p.err_msg_fg, bg = p.err_msg_bg, italic = true })
hi('WarningMsg', { fg = p.warn_msg_fg, bg = p.warn_msg_bg, italic = true })
hi('SuccessMsg', { fg = '#22dd22', bg = p.ok_bg, italic = true })
hi('MoreMsg', { fg = p.info, bold = true })
hi('InfoMsg', { fg = p.info, bg = p.info_bg, italic = true })
hi('Question', {})

-- Native Neovim diagnostics. Virtual text gets a tinted background while the
-- source range itself gets both underline and undercurl for terminal fallback.
hi('DiagnosticError', { fg = p.err, nocombine = true })
hi('DiagnosticWarn', { fg = p.warn, nocombine = true })
hi('DiagnosticInfo', { fg = p.info })
hi('DiagnosticHint', { fg = p.hint })
hi('DiagnosticOk', { fg = p.ok })
hi('DiagnosticRangeError', { fg = p.err, underline = true, undercurl = true, sp = p.err, nocombine = true })
hi('DiagnosticRangeWarn', { fg = p.warn, underline = true, undercurl = true, sp = p.warn, nocombine = true })
hi('DiagnosticRangeInfo', { fg = p.info, underline = true, undercurl = true, sp = p.info, nocombine = true })
hi('DiagnosticRangeHint', { fg = p.hint, underline = true, undercurl = true, sp = p.hint, nocombine = true })
hi('DiagnosticSignError', { fg = p.err, bg = p.bg0 })
hi('DiagnosticSignWarn', { fg = p.warn, bg = p.bg0 })
hi('DiagnosticSignInfo', { fg = p.info, bg = p.bg0 })
hi('DiagnosticSignHint', { fg = p.hint, bg = p.bg0 })
hi('DiagnosticVirtualTextError', { fg = p.err_msg_fg, bg = p.err_msg_bg, italic = true })
hi('DiagnosticVirtualTextWarn', { fg = p.warn_msg_fg, bg = p.warn_msg_bg, italic = true })
hi('DiagnosticVirtualTextInfo', { fg = p.info, bg = p.info_bg, italic = true })
hi('DiagnosticVirtualTextHint', { fg = p.hint, bg = p.hint_bg, italic = true })
hi('DiagnosticUnderlineError', { underline = true, undercurl = true, sp = p.err })
hi('DiagnosticUnderlineWarn', { underline = true, undercurl = true, sp = p.warn })
hi('DiagnosticUnderlineInfo', { underline = true, undercurl = true, sp = p.info })
hi('DiagnosticUnderlineHint', { underline = true, undercurl = true, sp = p.hint })
hi('LspReferenceText', { bg = p.bg4 })
hi('LspReferenceRead', { bg = p.bg4 })
hi('LspReferenceWrite', { bg = p.bg4 })

-- Quickfix and netrw are carried over from the old Vim customizations so those
-- buffers do not fall back to generic defaults.
hi('QuickFixLine', { link = 'Normal' })
hi('QuickFixBackground', { fg = p.dim0, bg = p.bg3 })
hi('QFCursorLine', { bg = p.warn_msg_bg })
hi('QFNormal', { bg = p.bg2 })
hi('QFEndOfBuffer', { fg = p.bg2 })
hi('qfPath', { fg = p.fg0 })
hi('qfLineNr', { fg = p.fg0 })
hi('qfFileName', { fg = p.fg0 })
hi('qfError', { fg = p.err_msg_fg, bg = p.err_msg_bg })
hi('qfSeparator', { fg = '#2a2a2a' })
hi('qfTestNameSuccess', { fg = p.ok })
hi('qfTestNameError', { fg = p.err_msg_fg })
hi('qfTestNameWarning', { fg = p.warn })
hi('qfTiming', { fg = p.dim0 })
hi('qfFileNameSelected', { fg = p.fg0, bg = p.warn_msg_bg })
hi('qfSeparatorSelected', { fg = '#444422', bg = p.warn_msg_bg })
hi('qfTestNameSuccessSelected', { fg = p.ok, bg = p.warn_msg_bg })
hi('qfTestNameErrorSelected', { fg = p.err_msg_fg, bg = p.warn_msg_bg })
hi('qfTestNameWarningSelected', { fg = p.warn, bg = p.warn_msg_bg })
hi('qfTimingSelected', { fg = p.fg2, bg = p.warn_msg_bg })
hi('TestFailed', { link = 'ErrorMsg' })
hi('GTestOk', { fg = p.ok, bold = true })
hi('GTestPassed', { fg = p.ok, bold = true })
hi('GTestFailed', { fg = p.err_msg_fg, bold = true })
hi('GTestError', { link = 'ErrorMsg' })
hi('GTestNote', { link = 'WarningMsg' })
hi('ITestError', { fg = p.err_msg_fg, bold = true })
hi('ITestWarning', { fg = p.warn, bold = true })
hi('ITestSuccess', { fg = p.ok, bold = true })
hi('ITestErrorSelected', { fg = p.err_msg_fg, bg = p.warn_msg_bg, bold = true })
hi('ITestWarningSelected', { fg = p.warn, bg = p.warn_msg_bg, bold = true })
hi('ITestSuccessSelected', { fg = p.ok, bg = p.warn_msg_bg, bold = true })
hi('MSBuildError', { link = 'ErrorMsg' })
hi('MSBuildWarning', { link = 'WarningMsg' })
hi('MSBuildInfo', { link = 'InfoMsg' })
hi('MSBuildNote', { link = 'WarningMsg' })

hi('netrwDir', { fg = p.dim0, bold = true })
hi('netrwPlain', { fg = p.fg0 })
hi('netrwTreeBar', { fg = p.dim0 })
hi('netrwExe', { link = 'netrwPlain' })

-- LSP semantic tokens are intentionally collapsed back onto the classic syntax
-- groups to preserve the monotone look instead of introducing a rainbow.
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

-- Blink completion gets aligned with the same popup palette and muted metadata.
hi('BlinkCmpMenu', { link = 'Pmenu' })
hi('BlinkCmpMenuSelection', { link = 'PmenuSel' })
hi('BlinkCmpScrollBarThumb', { link = 'PmenuThumb' })
hi('BlinkCmpScrollBarGutter', { link = 'PmenuSbar' })
hi('BlinkCmpLabel', { fg = p.fg0 })
hi('BlinkCmpLabelDeprecated', { fg = p.dim0, strikethrough = true })
hi('BlinkCmpLabelMatch', { fg = p.hint, bold = true })
hi('BlinkCmpKind', { fg = p.fg2 })
hi('BlinkCmpSource', { fg = p.dim0 })

-- FzfLua gets its own groups so the picker chrome can match monotone without
-- affecting unrelated floating windows.
hi('FzfLuaNormal', { fg = p.fg0, bg = p.bg1 })
hi('FzfLuaBorder', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaTitle', { fg = p.fg0, bg = p.bg1, bold = true })
hi('FzfLuaTitleFlags', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaPreviewNormal', { fg = p.fg0, bg = p.bg1 })
hi('FzfLuaPreviewBorder', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaPreviewTitle', { fg = p.fg0, bg = p.bg1, bold = true })
hi('FzfLuaCursorLine', { fg = p.fg0, bg = p.bg3 })
hi('FzfLuaCursorLineNr', { fg = p.fg0, bg = p.bg3, bold = true })
hi('FzfLuaSearch', { fg = p.bg0, bg = p.warn, bold = true })
hi('FzfLuaScrollBorderEmpty', { fg = p.dim2, bg = p.bg1 })
hi('FzfLuaScrollBorderFull', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaScrollFloatEmpty', { fg = p.dim2, bg = p.bg3 })
hi('FzfLuaScrollFloatFull', { fg = p.hint, bg = p.bg3 })
hi('FzfLuaHeaderBind', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaHeaderText', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaPathLineNr', { fg = p.warn })
hi('FzfLuaPathColNr', { fg = p.err })
hi('FzfLuaDirIcon', { fg = p.dim0 })
hi('FzfLuaDirPart', { fg = p.dim0 })
hi('FzfLuaFilePart', { fg = p.fg0 })
hi('FzfLuaLivePrompt', { fg = p.warn, bold = true })
hi('FzfLuaFzfNormal', { fg = p.fg0, bg = p.bg1 })
hi('FzfLuaFzfCursorLine', { fg = p.fg0, bg = p.bg3 })
hi('FzfLuaFzfMatch', { fg = p.hint, bold = true })
hi('FzfLuaFzfBorder', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaFzfScrollbar', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaFzfSeparator', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaFzfGutter', { bg = p.bg1 })
hi('FzfLuaFzfHeader', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaFzfInfo', { fg = p.dim0, bg = p.bg1 })
hi('FzfLuaFzfPointer', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaFzfMarker', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaFzfSpinner', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaFzfPrompt', { fg = p.warn, bg = p.bg1, bold = true })
hi('FzfLuaFzfQuery', { fg = p.fg0, bg = p.bg1 })

-- Lualine reads its own theme file, but these groups keep a sensible fallback
-- if anything links directly to them.
hi('LualineNormalA', { fg = p.bg0, bg = p.fg0 })
hi('LualineInsertA', { fg = p.bg0, bg = '#a8d7af' })
hi('LualineVisualA', { fg = p.bg0, bg = '#ffffff' })
hi('LualineReplaceA', { fg = p.bg0, bg = p.err })
hi('LualineInactiveA', { fg = p.fg2, bg = p.dim2 })
