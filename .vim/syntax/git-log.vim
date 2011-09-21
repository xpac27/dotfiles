syntax match gitLogCommit       +^commit \x\{40}+
syntax match gitLogModif        +^[+-][+-][+-].*+
syntax match gitLogDiff         +^diff.*+
syntax match gitLogIndex        +^index.*+
syntax match gitDiffStatLine   /^[+-@][^+-].*$/ contains=gitDiffStatAdd,gitDiffStatDelete,gitDiffStatDetail
syntax match gitDiffStatAdd    /+.*/ contained
syntax match gitDiffStatDelete /-.*/ contained
syntax match gitDiffStatDetail /@.*/ contained

highlight gitLogCommit      ctermfg=231  cterm=bold
highlight gitLogModif       ctermfg=231  cterm=bold
highlight gitLogDiff        ctermfg=231  cterm=bold
highlight gitLogIndex       ctermfg=231  cterm=bold
highlight gitDiffStatAdd    ctermfg=34
highlight gitDiffStatDelete ctermfg=196
highlight gitDiffStatDetail ctermfg=110
