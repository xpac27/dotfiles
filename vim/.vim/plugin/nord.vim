let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_underline = 1

if (g:colors_name == 'nord')

    " Lsp
    hi Error guifg=#bf616a guibg=NONE cterm=undercurl
    hi Warning guifg=#ebcb8b guibg=NONE cterm=undercurl
    hi CurrentWord guibg=#3b4252

    " Darker background for more contrast
    hi Normal guifg=#D8DEE9 guibg=#1D2330 cterm=underline
    hi FoldColumn guifg=#4C566A guibg=#1D2330
    hi SignColumn guifg=#3B4252 guibg=#1D2330
    hi VertSplit guifg=#434C5E guibg=#1D2330

    let g:lightline.colorscheme = 'nord'
endif
