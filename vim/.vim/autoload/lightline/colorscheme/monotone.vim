" autoload/lightline/colorscheme/monotone.vim
" Monotone: dark neutrals + soft semantic accents
"
" Each color is: [ gui_hex, cterm_0_255 ]
" cterm values are chosen to be close in xterm-256.

" ----------------
" Neutral ramp
" ----------------
let s:bg0   = [ '#111111', 233 ] " deepest background
let s:bg1   = [ '#191919', 234 ] " main background
let s:bg2   = [ '#222222', 235 ] " slightly raised bg (panels)

let s:fg0   = [ '#d7d7d7', 188 ] " main foreground
let s:fg1   = [ '#bcbcbc', 250 ] " dimmer foreground
let s:fg2   = [ '#9e9e9e', 247 ] " even dimmer

let s:dim0  = [ '#4e4e4e', 239 ] " separators / muted text
let s:dim1  = [ '#3a3a3a', 237 ] " darker muted
let s:dim2  = [ '#626262', 241 ] " lighter muted

let s:none  = [ 'NONE', 'NONE' ]

" ----------------
" Mode accents (kept subtle / monotone-friendly)
" ----------------
let s:mode_normal  = [ '#d7d7d7', 188 ]
let s:mode_insert  = [ '#a8d7af', 151 ] " soft green
let s:mode_visual  = [ '#ffffff', 231 ] " bright
let s:mode_replace = [ '#ff9999', 210 ] " soft red

" ----------------
" Semantic accents (for component_type)
" ----------------
let s:warn_fg = [ '#eeee99', 228 ]
let s:warn_bg = [ '#222211', 235 ]

let s:err_fg  = [ '#ff9999', 210 ]
let s:err_bg  = [ '#221111', 235 ]

let s:info_fg = [ '#99ffff', 159 ]
let s:info_bg = [ '#112222', 235 ]

let s:hint_fg = [ '#c0c0ff', 147 ]
let s:hint_bg = [ '#111122', 235 ]

" ----------------
" Palette skeleton
" ----------------
let s:p = {
      \ 'normal':   {},
      \ 'insert':   {},
      \ 'visual':   {},
      \ 'replace':  {},
      \ 'inactive': {},
      \ 'tabline':  {},
      \ }

" ----------------
" Main statusline sections
" ----------------
" left/right entries correspond to groups inside g:lightline.active.left/right
let s:p.normal.left   = [ [ s:bg1, s:mode_normal ], [ s:fg2, s:bg0 ] ]
let s:p.normal.right  = [ [ s:fg1, s:dim0 ], [ s:fg2, s:dim2 ], [ s:fg2, s:bg0 ] ]
let s:p.normal.middle = [ [ s:fg2, s:bg1 ] ]

let s:p.insert.left   = [ [ s:bg1, s:mode_insert ], [ s:fg2, s:bg0 ] ]
let s:p.visual.left   = [ [ s:bg1, s:mode_visual ], [ s:fg2, s:bg0 ] ]
let s:p.replace.left  = [ [ s:bg1, s:mode_replace ], [ s:fg2, s:bg0 ] ]

let s:p.inactive.left   = [ [ s:fg2, s:bg1 ], [ s:dim0, s:bg0 ] ]
let s:p.inactive.right  = [ [ s:fg2, s:bg0 ], [ s:dim0, s:bg1 ] ]
let s:p.inactive.middle = [ [ s:dim0, s:bg1 ] ]

" ----------------
" Tabline
" ----------------
let s:p.tabline.left   = [ [ s:fg2, s:bg1 ] ]
let s:p.tabline.middle = [ [ s:dim0, s:bg1 ] ]
let s:p.tabline.right  = [ [ s:fg1, s:bg1 ] ]
let s:p.tabline.tabsel = [ [ s:bg1, s:mode_normal ] ]

" ----------------
" Component types (for g:lightline.component_type)
" ----------------
" Define in *all* modes so component_type works everywhere.
for s:m in ['normal', 'insert', 'visual', 'replace', 'inactive']
  let s:p[s:m].error   = [ [ s:err_fg,  s:err_bg  ] ]
  let s:p[s:m].warning = [ [ s:warn_fg, s:warn_bg ] ]
  let s:p[s:m].info    = [ [ s:info_fg, s:info_bg ] ]
  let s:p[s:m].hint    = [ [ s:hint_fg, s:hint_bg ] ]
endfor

let g:lightline#colorscheme#monotone#palette = lightline#colorscheme#flatten(s:p)
