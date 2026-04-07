let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_underline = 1

if (g:colors_name == 'nord')

    " Lsp
    hi Error guifg=#bf616a guibg=NONE cterm=undercurl
    hi Warning guifg=#ebcb8b guibg=NONE cterm=undercurl
    hi CurrentWord guibg=#3b4252
    hi CocHighlightText guibg=#3b4252
    hi CocHighlightRead guibg=#3b4252
    hi CocHighlightWrite guibg=#3b4252
    hi CocErrorHighlight guifg=#bf616a guibg=#3b2228 cterm=undercurl
    hi CocWarningHighlight guifg=#ebcb8b guibg=#3b3524 cterm=undercurl
    hi CocInfoHighlight guifg=#88c0d0 guibg=#22343b cterm=undercurl
    hi CocHintHighlight guifg=#a3be8c guibg=#2d3b2a cterm=undercurl
    hi CocErrorVirtualText guifg=#bf616a guibg=#3b2228
    hi CocWarningVirtualText guifg=#ebcb8b guibg=#3b3524
    hi CocInfoVirtualText guifg=#88c0d0 guibg=#22343b
    hi CocHintVirtualText guifg=#a3be8c guibg=#2d3b2a
    " Darker background for more contrast
    hi Normal guifg=#D8DEE9 guibg=#1D2330 cterm=underline
    hi FoldColumn guifg=#4C566A guibg=#1D2330
    hi SignColumn guifg=#3B4252 guibg=#1D2330
    hi VertSplit guifg=#434C5E guibg=#1D2330
    hi CocFloating guifg=#D8DEE9 guibg=#1D2330
    hi CocErrorFloat guifg=#bf616a guibg=#1D2330
    hi CocWarningFloat guifg=#ebcb8b guibg=#1D2330
    hi CocInfoFloat guifg=#88c0d0 guibg=#1D2330
    hi CocHintFloat guifg=#a3be8c guibg=#1D2330
    hi CocFloatBorder guifg=#4C566A guibg=#1D2330

    let g:lightline.colorscheme = 'nord'
endif
