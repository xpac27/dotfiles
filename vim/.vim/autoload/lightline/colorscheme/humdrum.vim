" Humdrum lightline palette. Colors are [gui_hex, cterm_0_255].

if &background ==# 'light'
  let s:bg1  = [ '#eeeeee', 255 ]
  let s:bg3  = [ '#dddddd', 253 ]
  let s:fg1  = [ '#4d4a4a', 239 ]
  let s:fg2  = [ '#5f5958', 240 ]
  let s:dim0 = [ '#8a8585', 245 ]
  let s:dim2 = [ '#b8b1b1', 250 ]

  let s:normal  = [ '#393636', 236 ]
  let s:insert  = [ '#5f8f5f', 65 ]
  let s:visual  = [ '#000000', 16 ]
  let s:replace = [ '#a85f5f', 131 ]

  let s:warn_fg = [ '#8c842f', 101 ]
  let s:warn_bg = [ '#f0ecd2', 230 ]
  let s:err_fg  = [ '#a85f5f', 131 ]
  let s:err_bg  = [ '#f4dddd', 224 ]
  let s:info_fg = [ '#3d8484', 66 ]
  let s:info_bg = [ '#d9eded', 195 ]
  let s:hint_fg = [ '#6f6fa6', 103 ]
  let s:hint_bg = [ '#e4e4f2', 254 ]
else
  let s:bg1  = [ '#191919', 234 ]
  let s:bg3  = [ '#2a2a2a', 235 ]
  let s:fg1  = [ '#bcbcbc', 250 ]
  let s:fg2  = [ '#9e9e9e', 247 ]
  let s:dim0 = [ '#4e4e4e', 239 ]
  let s:dim2 = [ '#626262', 241 ]

  let s:normal  = [ '#d7d7d7', 188 ]
  let s:insert  = [ '#a8d7af', 151 ]
  let s:visual  = [ '#ffffff', 231 ]
  let s:replace = [ '#ff9999', 210 ]

  let s:warn_fg = [ '#eeee99', 228 ]
  let s:warn_bg = [ '#222211', 235 ]
  let s:err_fg  = [ '#ff9999', 210 ]
  let s:err_bg  = [ '#221111', 235 ]
  let s:info_fg = [ '#99ffff', 159 ]
  let s:info_bg = [ '#112222', 235 ]
  let s:hint_fg = [ '#c0c0ff', 147 ]
  let s:hint_bg = [ '#111122', 235 ]
endif

let s:p = {
      \ 'normal':   {},
      \ 'insert':   {},
      \ 'visual':   {},
      \ 'replace':  {},
      \ 'inactive': {},
      \ 'tabline':  {},
      \ }

" Main statusline sections.
let s:p.normal.left   = [ [ s:bg1, s:normal ], [ s:fg2, s:bg3 ] ]
let s:p.normal.right  = [ [ s:fg1, s:dim0 ], [ s:fg2, s:dim2 ], [ s:fg2, s:bg3 ] ]
let s:p.normal.middle = [ [ s:fg2, s:bg3 ] ]
let s:p.insert.left   = [ [ s:bg1, s:insert ], [ s:fg2, s:bg3 ] ]
let s:p.visual.left   = [ [ s:bg1, s:visual ], [ s:fg2, s:bg3 ] ]
let s:p.replace.left  = [ [ s:bg1, s:replace ], [ s:fg2, s:bg3 ] ]
let s:p.inactive.left   = [ [ s:fg2, s:bg3 ], [ s:dim0, s:bg3 ] ]
let s:p.inactive.right  = [ [ s:fg2, s:bg3 ], [ s:dim0, s:bg3 ] ]
let s:p.inactive.middle = [ [ s:dim0, s:bg3 ] ]

" Tabline.
let s:p.tabline.left   = [ [ s:fg2, s:bg1 ] ]
let s:p.tabline.middle = [ [ s:dim0, s:bg1 ] ]
let s:p.tabline.right  = [ [ s:fg1, s:bg1 ] ]
let s:p.tabline.tabsel = [ [ s:bg1, s:normal ] ]

" Diagnostic component types from g:lightline.component_type.
for s:m in ['normal', 'insert', 'visual', 'replace', 'inactive']
  let s:p[s:m].error   = [ [ s:err_fg,  s:err_bg  ] ]
  let s:p[s:m].warning = [ [ s:warn_fg, s:warn_bg ] ]
  let s:p[s:m].info    = [ [ s:info_fg, s:info_bg ] ]
  let s:p[s:m].hint    = [ [ s:hint_fg, s:hint_bg ] ]
endfor

let g:lightline#colorscheme#humdrum#palette = lightline#colorscheme#flatten(s:p)
