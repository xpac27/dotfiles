if (g:colors_name == 'monotone')

    " Overrides
    hi Include guifg=#666666
    hi Type guifg=#dddddd
    hi SpecialKey guifg=#ff9999

    " Lsp
    hi Error guifg=#ff9999 guibg=NONE cterm=undercurl
    hi Warning guifg=#eeee99 guibg=NONE cterm=undercurl
    hi Success guifg=#99ff99 guibg=NONE cterm=undercurl
    hi ErrorMsg guifg=#ff4444 guibg=#221111 cterm=italic
    hi WarningMsg guifg=#dd9922 guibg=#222211 cterm=italic
    hi SuccessMsg guifg=#22dd22 guibg=#112211 cterm=italic
    hi InfoMsg guifg=#99ffff guibg=#112222 cterm=italic
    hi NoteMsg guifg=#ffffcc guibg=#222211
    hi MatchParen guifg=#d7d7d7 guibg=#444444 cterm=bold
    hi CurrentWord guibg=#444444
    hi CocHighlightText guibg=#444444
    hi CocHighlightRead guibg=#444444
    hi CocHighlightWrite guibg=#444444

    " Autocompletion menu
    hi Pmenu guifg=#9999ff guibg=#111122
    hi PmenuSel guifg=#eeeeff guibg=#333344
    hi PmenuSbar guibg=#333344
    hi PmenuThumb guibg=#9999ff
    hi CocFloating guifg=#9999ff guibg=#111122

    " Copilot
    hi CopilotSuggestion guifg=#9999ff guibg=#111122

    " Fzf
    hi FzfBackground guifg=#d7d7d7 guibg=#111122
    hi FzfSelected guifg=#dddddd guibg=#222211
    hi FzfMatch guifg=#dd9922 guibg=NONE gui=bold cterm=bold
    hi FzfMatchSelected guifg=#eeee99 guibg=#222211 gui=bold cterm=bold
    hi FzfMarker guifg=#eeee99 guibg=NONE

    " Status line
    hi StatusLine guibg=#111111
    hi StatusLineNC guibg=#111111 guifg=#111111
    hi Include guifg=#666666
    hi Type guifg=#dddddd

    " Quickfix
    hi! link QuickFixLine CursorLine
    hi QuickFixBackground guifg=#666666 guibg=#333333 " Custom group
    hi qfError guifg=#ff4444 guibg=#221111
    hi qfSeparator guifg=#2a2a2a
    hi qfLineNr guifg=#d7d7d7
    hi qfFileName guifg=#d7d7d7
    hi link TestFailed ErrorMsg
    hi link GTestOk Success
    hi link GTestPassed Success
    hi link GTestFailed ErrorMsg
    hi link GTestError ErrorMsg
    hi link GTestNote NoteMsg
    hi link ITestError Error
    hi link ITestWarning Warning
    hi link ITestSuccess Success
    hi link MSBuildError ErrorMsg
    hi link MSBuildWarning WarningMsg
    hi link MSBuildInfo InfoMsg
    hi link MSBuildNote NoteMsg

    " netrw
    hi netrwDir cterm=bold guifg=#666666
    hi netrwPlain cterm=none guifg=#d7d7d7
    hi netrwTreeBar guifg=#666666
    hi link netrwExe netrwPlain

    " LSP semantic
    hi! link LspSemanticType Type
    hi! link LspSemanticClass Type
    hi! link LspSemanticEnum Type
    hi! link LspSemanticInterface Type
    hi! link LspSemanticStruct Type
    hi! link LspSemanticTypeParameter Type
    " hi! link LspSemanticParameter TSParameter
    " hi! link LspSemanticVariable TSVariable
    " hi! link LspSemanticProperty TSProperty
    " hi! link LspSemanticEnumMember TSProperty
    hi! link LspSemanticEvents Label
    hi! link LspSemanticFunction Function
    " hi! link LspSemanticMethod TSMethod
    hi! link LspSemanticKeyword Keyword
    hi! link LspSemanticModifier Operator
    hi! link LspSemanticComment Comment
    " hi! link LspSemanticString String
    hi! link LspSemanticNumber Number
    " hi! link LspSemanticRegexp TSStringRegex
    hi! link LspSemanticOperator Operator
    hi link LspInformationHighlight NoteMsg
    hi link LspInformationText InfoMsg
    hi CocErrorHighlight guifg=#ff9999 guibg=#221111 cterm=undercurl
    hi CocWarningHighlight guifg=#eeee99 guibg=#222211 cterm=undercurl
    hi CocInfoHighlight guifg=#99ffff guibg=#112222 cterm=undercurl
    hi CocHintHighlight guifg=#ffffcc guibg=#222211 cterm=undercurl
    hi CocErrorVirtualText guifg=#ff4444 guibg=#221111 cterm=italic
    hi CocWarningVirtualText guifg=#dd9922 guibg=#222211 cterm=italic
    hi CocInfoVirtualText guifg=#99ffff guibg=#112222 cterm=italic
    hi CocHintVirtualText guifg=#ffffcc guibg=#222211 cterm=italic
    hi CocErrorFloat guifg=#9999ff guibg=#111122 cterm=italic
    hi CocWarningFloat guifg=#9999ff guibg=#111122 cterm=italic
    hi CocInfoFloat guifg=#9999ff guibg=#111122 cterm=italic
    hi CocHintFloat guifg=#9999ff guibg=#111122 cterm=italic
    hi CocFloatBorder guifg=#9999ff guibg=#111122

    " Lightline
    let g:lightline.colorscheme = 'monotone'
endif
