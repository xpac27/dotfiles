runtime syntax/diff.vim

syntax match gitLogIndex        +^index.*+
syntax match gitLogDiff         +^diff.*+
syntax match gitDiffStatLine   /^[+-@][^+-]*.*$/ contains=gitDiffStatAdd,gitDiffStatDelete,gitDiffStatDetail
syntax match gitDiffStatAdd    /+.*/ contained
syntax match gitDiffStatDelete /-.*/ contained
syntax match gitDiffStatDetail /@.*/ contained

highlight gitLogIndex       ctermfg=231  cterm=bold
highlight gitLogDiff        ctermfg=231  cterm=bold
highlight gitDiffStatAdd    ctermfg=34
highlight gitDiffStatDelete ctermfg=196
highlight gitDiffStatDetail ctermfg=110
