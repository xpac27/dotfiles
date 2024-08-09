if exists("current_compiler")
  finish
endif
let current_compiler = "gtest"

CompilerSet makeprg=
CompilerSet errorformat=
      \%W%m\ (Cucumber::Undefined),
      \%E%m\ (%\\S%#),
      \%Z%f:%l,
      \%Z%f:%l:%.%#
