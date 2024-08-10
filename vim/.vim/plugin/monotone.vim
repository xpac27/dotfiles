if (g:colors_name == 'monotone')

    " Lsp
    hi Error guifg=#ff9999 guibg=NONE cterm=undercurl
    hi Warning guifg=#eeee99 guibg=NONE cterm=undercurl
    hi ErrorMsg guifg=#ff4444 guibg=#221111 cterm=italic
    hi WarningMsg guifg=#dd9922 guibg=#222211 cterm=italic
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
    highlight QuickFixBackground guifg=#666666 guibg=#2a2a2a " Custom group
    hi! link QuickFixLine CursorLine
    hi TestOk guifg=#99ff99 guibg=#112211 " Custom group for gtest
    hi TestRun guifg=#d7d7d7 guibg=#222222 " Custom group for gtest
    hi TestFailed guifg=#ff4444 guibg=#221111 " Custom group for gtest
    hi qfError guifg=#ff4444 guibg=#221111
    hi qfSeparator guifg=#2a2a2a
    hi qfLineNr guifg=#d7d7d7
    hi qfFileName guifg=#d7d7d7

    let g:lightline.colorscheme = 'monotone'
endif
