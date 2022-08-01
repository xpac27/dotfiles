" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_invert_selection=0
let g:gruvbox_inverse=0
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_improved_strings=0   
let g:gruvbox_improved_warnings=1

colorscheme gruvbox
hi Search guifg=#504945 guibg=#fabd2f
hi CocHighlightText guibg=#504945
hi StatusLine guibg=#504945
hi StatusLineNC guibg=#504945
