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

if (g:colors_name == 'gruvbox')
  hi Search guifg=#504945 guibg=#fabd2f
  hi CocFloating guifg=#ebdbb2 guibg=#282828
  hi CocHighlightText guibg=#504945
  hi CocHighlightRead guibg=#504945
  hi CocHighlightWrite guibg=#504945
  hi CocErrorHighlight guifg=#fb4934 guibg=#3c1f1e cterm=undercurl
  hi CocWarningHighlight guifg=#fabd2f guibg=#3c321f cterm=undercurl
  hi CocInfoHighlight guifg=#83a598 guibg=#25363a cterm=undercurl
  hi CocHintHighlight guifg=#b8bb26 guibg=#34381f cterm=undercurl
  hi CocErrorVirtualText guifg=#fb4934 guibg=#3c1f1e
  hi CocWarningVirtualText guifg=#fabd2f guibg=#3c321f
  hi CocInfoVirtualText guifg=#83a598 guibg=#25363a
  hi CocHintVirtualText guifg=#b8bb26 guibg=#34381f
  hi CocErrorFloat guifg=#fb4934 guibg=#282828
  hi CocWarningFloat guifg=#fabd2f guibg=#282828
  hi CocInfoFloat guifg=#83a598 guibg=#282828
  hi CocHintFloat guifg=#b8bb26 guibg=#282828
  hi CocFloatBorder guifg=#928374 guibg=#282828
  hi StatusLine guibg=#504945
  hi StatusLineNC guibg=#504945

  let g:lightline.colorscheme = 'gruvbox'
endif
