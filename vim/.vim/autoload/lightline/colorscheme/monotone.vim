let s:black = [ '#191919', '0' ]
let s:black2 = [ '#111111', '233' ]

let s:gray = [ '#4e4e4e', '235' ]
let s:gray2 = [ '#4e4e4e', '237' ]
let s:gray3 = [ '#4e4e4e', '239' ]
let s:gray4 = [ '#4e4e4e', '241' ]

let s:violet = [ '#ffffff', '170' ]

let s:blue = [ '#d7d7d7', '67' ]
let s:blue2 = [ '#eeee99', '110' ]

let s:green = [ '#4e4e4e', '71' ]
let s:gold = [ '#eeee99', '220' ]
let s:red = [ '#ff9999', '160' ]
let s:none = [ 'NONE', 'NONE' ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:blue ], [ s:gray4, s:black2 ] ]
let s:p.normal.right = [ [ s:gray, s:gray4 ], [ s:gray3, s:gray ], [ s:gray2, s:black2 ] ]
let s:p.inactive.right = [ [ s:black, s:black2 ], [ s:gray, s:black ] ]
let s:p.inactive.left =  [ [ s:gray, s:black ], [ s:black2, s:black ] ]
let s:p.insert.left = [ [ s:black, s:green ], [ s:gray4, s:black2 ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:gray4, s:black2 ] ]
let s:p.visual.left = [ [ s:black, s:violet ], [ s:gray4, s:black2 ] ]
let s:p.normal.middle = [ [ s:gray, s:black ] ]
let s:p.inactive.middle = [ [ s:black2, s:black ] ]
let s:p.tabline.left = [ [ s:gray4, s:black ] ]
let s:p.tabline.tabsel = [ [ s:blue, s:black ] ]
let s:p.tabline.middle = [ [ s:black2, s:black ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:gold, s:black2 ] ]

let g:lightline#colorscheme#monotone#palette = lightline#colorscheme#flatten(s:p)

