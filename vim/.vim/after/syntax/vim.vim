" vim-css-color covers normal Vim strings, but continued dictionaries use
" vimContinueString. Humdrum stores its palette in one of those dictionaries.
if exists('*css_color#init')
  call css_color#init('hex', 'none', 'vimContinueString')
endif
