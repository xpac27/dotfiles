" Shared quickfix/location-list entry structure for the custom quickfixtextfunc
" output: "path | text".
silent! syntax clear qfFileName
silent! syntax clear qfSeparator1
silent! syntax clear qfLineNr
silent! syntax clear qfSeparator2
silent! syntax clear qfText

syntax match qfFileName "^[^|]\+\ze\s|\s" contains=qfError
syntax match qfSeparator "\s|\s" contains=NONE
