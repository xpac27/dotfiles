let g:bookmark_sign = '🚩'
let g:bookmark_annotation_sign = '📋'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
if exists('theme') && theme == 'light'
else
    hi BookmarkLine guibg=#504945 guifg=#fbf1c7
    hi BookmarkAnnotationLine guibg=#504945 guifg=#fbf1c7
endif
