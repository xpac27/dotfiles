if (g:colors_name == 'monotone')

    " Lsp
    hi Error guifg=#ff9999 guibg=NONE cterm=undercurl
    hi Warning guifg=#eeee99 guibg=NONE cterm=undercurl
    hi ErrorMsg guifg=#ff4444 guibg=#221111 cterm=italic
    hi WarningMsg guifg=#dd9922 guibg=#222211 cterm=italic
    hi MatchParen guifg=#d7d7d7 guibg=#444444 cterm=bold
    hi CurrentWord guibg=#444444

    hi StatusLine guibg=#111111
    hi StatusLineNC guibg=#111111 guifg=#111111

    let g:lightline.colorscheme = 'monotone'
endif
