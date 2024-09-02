if (g:colors_name == 'monotone')

    " Overrides
    hi Include guifg=#666666
    hi Type guifg=#dddddd

    " Lsp
    hi Error guifg=#ff9999 guibg=NONE cterm=undercurl
    hi Warning guifg=#eeee99 guibg=NONE cterm=undercurl
    hi ErrorMsg guifg=#ff4444 guibg=#221111 cterm=italic
    hi WarningMsg guifg=#dd9922 guibg=#222211 cterm=italic
    hi SuccessMsg guifg=#99ff99 guibg=#112211 cterm=italic
    hi InfoMsg guifg=#99ffff guibg=#112222 cterm=italic
    hi NoteMsg guifg=#ffffcc guibg=#222211
    hi MatchParen guifg=#d7d7d7 guibg=#444444 cterm=bold
    hi CurrentWord guibg=#444444

    " Autocompletion menu
    hi Pmenu guifg=#9999ff guibg=#111122
    hi PmenuSel guifg=#eeeeff guibg=#333344
    hi PmenuSbar guibg=#333344
    hi PmenuThumb guibg=#9999ff

    " Copilot
    hi CopilotSuggestion guifg=#9999ff guibg=#111122

    " Status line
    hi StatusLine guibg=#111111
    hi StatusLineNC guibg=#111111 guifg=#111111
    hi Include guifg=#666666
    hi Type guifg=#dddddd

    " Quickfix
    hi! link QuickFixLine CursorLine
    hi QuickFixBackground guifg=#666666 guibg=#2a2a2a " Custom group
    hi qfError guifg=#ff4444 guibg=#221111
    hi qfSeparator guifg=#2a2a2a
    hi qfLineNr guifg=#d7d7d7
    hi qfFileName guifg=#d7d7d7
    hi link TestFailed ErrorMsg
    hi link GTestOk SuccessMsg
    hi link GTestPassed SuccessMsg
    hi link GTestFailed ErrorMsg
    hi link GTestError ErrorMsg
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

    " Lightline
    let g:lightline.colorscheme = 'monotone'
endif
