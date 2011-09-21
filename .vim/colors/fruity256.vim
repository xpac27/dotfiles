"
" Fruity Color Scheme
" ===================
"
" Author:   Armin Ronacher <armin.ronacher@active-4.com>
" Version:  0.2
"
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "fruity"

" Default Colors
hi Normal       guifg=#ffffff ctermfg=231   guibg=#111111 ctermbg=232
hi NonText      guifg=#444444 ctermfg=238   guibg=#000000 ctermbg=16
hi Cursor       guibg=#aaaaaa ctermbg=248
hi lCursor      guibg=#aaaaaa ctermbg=248

" Search
hi Search       guifg=#800000 ctermfg=88   guibg=#ffae00 ctermbg=166
hi IncSearch    guifg=#800000 ctermfg=88   guibg=#ffae00 ctermbg=166

" Window Elements
hi StatusLine   guifg=#ffffff ctermfg=231   guibg=#8090a0 ctermbg=247   gui=bold
hi StatusLineNC guifg=#506070 ctermfg=60   guibg=#a0b0c0 ctermbg=110
hi VertSplit    guifg=#a0b0c0 ctermfg=110   guibg=#a0b0c0 ctermbg=110
hi Folded       guifg=#111111 ctermfg=232   guibg=#8090a0 ctermbg=247
hi IncSearch    guifg=#708090 ctermfg=103   guibg=#f0e68c ctermbg=221
hi Pmenu        guifg=#ffffff ctermfg=231   guibg=#cb2f27 ctermbg=124
hi SignColumn   guibg=#111111 ctermbg=232
hi CursorLine   guibg=#181818 ctermbg=233
hi LineNr       guifg=#aaaaaa ctermfg=248   guibg=#222222 ctermbg=234

" Specials
hi Todo         guifg=#e50808 ctermfg=160   guibg=#520000 ctermbg=52   gui=bold
hi Title        guifg=#ffffff ctermfg=231                   gui=bold
hi Special      guifg=#fd8900 ctermfg=208

" Syntax Elements
hi String       guifg=#0086d2 ctermfg=69
hi Constant     guifg=#0086d2 ctermfg=69
hi Number       guifg=#0086f7 ctermfg=75                   gui=bold
hi Statement    guifg=#fb660a ctermfg=202                   gui=bold
hi Function     guifg=#ff0086 ctermfg=197                   gui=bold
hi PreProc      guifg=#ff0007 ctermfg=196                   gui=bold
hi Comment      guifg=#00d2ff ctermfg=45   guibg=#0f140f ctermbg=233   gui=italic
hi Type         guifg=#cdcaa9 ctermfg=187                   gui=bold
hi Error        guifg=#ffffff ctermfg=231   guibg=#ab0000 ctermbg=124
hi Identifier   guifg=#ff0086 ctermfg=197                   gui=bold
hi Label        guifg=#ff0086 ctermfg=197

" Python Highlighting for python.vim
hi pythonCoding guifg=#ff0086 ctermfg=197
hi pythonRun    guifg=#ff0086 ctermfg=197
hi pythonBuiltinObj     guifg=#2b6ba2 ctermfg=25           gui=bold
hi pythonBuiltinFunc    guifg=#2b6ba2 ctermfg=25           gui=bold
hi pythonException      guifg=#ee0000 ctermfg=196           gui=bold
hi pythonExClass        guifg=#66cd66 ctermfg=113           gui=bold
hi pythonSpaceError     guibg=#270000 ctermbg=235
hi pythonDocTest    guifg=#2f5f49 ctermfg=22
hi pythonDocTest2   guifg=#3b916a ctermfg=29
hi pythonFunction   guifg=#ee0000 ctermfg=196               gui=bold
hi pythonClass      guifg=#ff0086 ctermfg=197               gui=bold

" JavaScript Highlighting
hi javaScript                   guifg=#ffffff ctermfg=231
hi javaScriptRegexpString       guifg=#aa6600 ctermfg=94
hi javaScriptDocComment         guifg=#aaaaaa ctermfg=248
hi javaScriptCssStyles          guifg=#dd7700 ctermfg=172
hi javaScriptDomElemFuncs       guifg=#66cd66 ctermfg=113
hi javaScriptHtmlElemFuncs      guifg=#dd7700 ctermfg=172
hi javaScriptLabel              guifg=#00bdec ctermfg=75   gui=italic
hi javaScriptPrototype          guifg=#00bdec ctermfg=75
hi javaScriptConditional        guifg=#ff0007 ctermfg=196   gui=bold
hi javaScriptRepeat             guifg=#ff0007 ctermfg=196   gui=bold
hi javaScriptFunction           guifg=#ff0086 ctermfg=197   gui=bold

" CSS Highlighting
hi cssIdentifier            guifg=#66cd66 ctermfg=113       gui=bold
hi cssBraces                guifg=#00bdec ctermfg=75       gui=bold

" Ruby Highlighting
hi rubyFunction     guifg=#0066bb ctermfg=26               gui=bold
hi rubyClass        guifg=#ff0086 ctermfg=197               gui=bold
hi rubyModule       guifg=#ff0086 ctermfg=197               gui=bold,underline
hi rubyKeyword      guifg=#008800 ctermfg=28               gui=bold
hi rubySymbol       guifg=#aa6600 ctermfg=94
hi rubyIndentifier              guifg=#008aff ctermfg=33
hi rubyGlobalVariable           guifg=#dd7700 ctermfg=172
hi rubyConstant                 guifg=#5894d2 ctermfg=68   gui=bold
hi rubyBlockParameter           guifg=#66cd66 ctermfg=113
hi rubyPredefinedIdentifier     guifg=#555555 ctermfg=240   gui=bold
hi rubyString           guifg=#0086d2 ctermfg=69
hi rubyStringDelimiter  guifg=#dd7700 ctermfg=172
hi rubySpaceError       guibg=#270000 ctermbg=235
hi rubyDocumentation    guifg=#aaaaaa ctermfg=248
hi rubyData             guifg=#555555 ctermfg=240

" XML Highlighting
hi xmlTag           guifg=#00bdec ctermfg=75
hi xmlTagName       guifg=#00bdec ctermfg=75
hi xmlEndTag        guifg=#00bdec ctermfg=75
hi xmlNamespace     guifg=#00bdec ctermfg=75                   gui=underline
hi xmlAttribPunct   guifg=#cccaa9 ctermfg=187                   gui=bold
hi xmlEqual         guifg=#cccaa9 ctermfg=187                   gui=bold
hi xmlCdata         guifg=#bf0945 ctermfg=161                   gui=bold
hi xmlCdataCdata	guifg=#ac1446 ctermfg=125   guibg=#23010c ctermbg=235   gui=none
hi xmlCdataStart	guifg=#bf0945 ctermfg=161                   gui=bold
hi xmlCdataEnd		guifg=#bf0945 ctermfg=161                   gui=bold

" HTML Highlighting
hi htmlTag          guifg=#00bdec ctermfg=75               gui=bold
hi htmlEndTag       guifg=#00bdec ctermfg=75               gui=bold
hi htmlSpecialTagName   guifg=#66cd66 ctermfg=113
hi htmlTagName      guifg=#66cd66 ctermfg=113
hi htmlTagN         guifg=#66cd66 ctermfg=113
hi htmlEvent        guifg=#ffffff ctermfg=231

" Django Highlighting
hi djangoTagBlock   guifg=#ff0007 ctermfg=196   guibg=#200000 ctermbg=235   gui=bold
hi djangoVarBlock   guifg=#ff0007 ctermfg=196   guibg=#200000 ctermbg=235
hi djangoArgument   guifg=#0086d2 ctermfg=69   guibg=#200000 ctermbg=235
hi djangoStatement  guifg=#fb660a ctermfg=202   guibg=#200000 ctermbg=235   gui=bold
hi djangoComment    guifg=#008800 ctermfg=28   guibg=#002300 ctermbg=235   gui=italic
hi djangoFilter     guifg=#ff0086 ctermfg=197   guibg=#200000 ctermbg=235   gui=italic

" Jinja Highlighting
hi jinjaTagBlock    guifg=#ff0007 ctermfg=196   guibg=#200000 ctermbg=235   gui=bold
hi jinjaVarBlock    guifg=#ff0007 ctermfg=196   guibg=#200000 ctermbg=235
hi jinjaString      guifg=#0086d2 ctermfg=69   guibg=#200000 ctermbg=235
hi jinjaNumber      guifg=#bf0945 ctermfg=161   guibg=#200000 ctermbg=235   gui=bold
hi jinjaStatement   guifg=#fb660a ctermfg=202   guibg=#200000 ctermbg=235   gui=bold
hi jinjaComment     guifg=#008800 ctermfg=28   guibg=#002300 ctermbg=235   gui=italic
hi jinjaFilter      guifg=#ff0086 ctermfg=197   guibg=#200000 ctermbg=235
hi jinjaRaw         guifg=#aaaaaa ctermfg=248   guibg=#200000 ctermbg=235
hi jinjaOperator    guifg=#ffffff ctermfg=231   guibg=#200000 ctermbg=235
hi jinjaVariable    guifg=#92cd35 ctermfg=113   guibg=#200000 ctermbg=235
hi jinjaAttribute   guifg=#dd7700 ctermfg=172   guibg=#200000 ctermbg=235
hi jinjaSpecial     guifg=#008ffd ctermfg=39   guibg=#200000 ctermbg=235

" ERuby Highlighting (for my eruby.vim)
hi erubyRubyDelim   guifg=#2c8a16 ctermfg=28                   gui=bold
hi erubyComment     guifg=#4d9b3a ctermfg=70                   gui=italic
