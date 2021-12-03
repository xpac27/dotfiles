" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_vert_split="bg0"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_color_column="bg0"
let g:gruvbox_invert_selection=0
let g:gruvbox_inverse=1
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_improved_strings=0   
let g:gruvbox_improved_warnings=1

colorscheme gruvbox
" hi VertSplit guifg=#504945
" hi Search guifg=#666666 guibg=#ffffff
" hi ColorColumn guibg=#1d2021
" hi CocHighlightText guibg=#665c54
" hi Search guibg=#fbf1c7 guifg=#d79921
