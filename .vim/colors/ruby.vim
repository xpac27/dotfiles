hi clear

set background=dark
let g:colors_name="ruby"

if &t_Co > 255

    """""""""""""""
    " code
    """""""""""""""

    highlight Constant                   ctermfg=138                 cterm=none
    highlight String                     ctermfg=138
    highlight Character                  ctermfg=138
    highlight Number                     ctermfg=138
    highlight Boolean                    ctermfg=138
    highlight Float                      ctermfg=138

    highlight Identifier                 ctermfg=231
    highlight Function                   ctermfg=184                 cterm=bold

    highlight Statement                  ctermfg=215                 cterm=bold
"    highlight Conditional                ctermfg=231
"    highlight Repeat                     ctermfg=231
"    highlight Label                      ctermfg=231
"    highlight Operator                   ctermfg=231
"    highlight Exception                  ctermfg=231
"    highlight Keyword                    ctermfg=231

    highlight PreProc                    ctermfg=215                 cterm=bold
"    highlight Include                    ctermfg=231
"    highlight Define                     ctermfg=74
"    highlight Macro                      ctermfg=231
"    highlight PreCondit                  ctermfg=231

    highlight Type                       ctermfg=231
"    highlight StorageClass               ctermfg=231
"    highlight Structure                  ctermfg=231
"    highlight Typedef                    ctermfg=231

    highlight Special                    ctermfg=231

    highlight Error                      ctermfg=196    ctermbg=88

    hi Search                            ctermfg=221    ctermbg=235   cterm=none
    hi MatchParen                        ctermfg=231    ctermbg=22    cterm=none

    hi Todo                              ctermfg=160    ctermbg=52    cterm=bold

    hi Comment                           ctermfg=59


    """""""""""""""
    " ruby
    """""""""""""""

    highlight pythonBuiltin              ctermfg=231                  cterm=bold
    highlight rubyBlockParameter         ctermfg=231                  cterm=bold
    highlight rubyClass                  ctermfg=199                  cterm=bold
    highlight rubyConstant               ctermfg=231                  cterm=bold
    highlight rubyInstanceVariable       ctermfg=252
    highlight rubyInterpolation          ctermfg=231                  cterm=bold
    highlight rubyLocalVariableOrMethod  ctermfg=231                  cterm=bold
    highlight rubyPredefinedConstant     ctermfg=231                  cterm=bold
    highlight rubyPseudoVariable         ctermfg=231                  cterm=bold
    highlight rubyStringDelimiter        ctermfg=138


    """""""""""""""
    " complete menu
    """""""""""""""

    hi Pmenu           ctermfg=244 ctermbg=236
    hi PmenuSel        ctermfg=231 ctermbg=240


    """""""""""""""
    " interface
    """""""""""""""

    hi StatusLineNC    ctermfg=235 ctermbg=238
    hi StatusLine      ctermfg=235 ctermbg=221
    hi VertSplit       ctermfg=235 ctermbg=234
    hi Visual          ctermfg=250 ctermbg=24
    hi WarningMsg      ctermfg=231               cterm=bold
    hi WildMenu        ctermfg=16                cterm=bold

    hi Normal          ctermfg=250 ctermbg=234
    hi LineNr          ctermfg=238 ctermbg=235
    hi NonText         ctermfg=235 ctermbg=234

end

