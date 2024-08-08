if exists("current_compiler")
  finish
endif
let current_compiler = "custom_msvc"

CompilerSet makeprg=make
CompilerSet errorformat= %f(%l):\ %trror\ C%n:\ %m,
                         %f(%l):\ %tarning\ C%n:\ %m,
                         %f(%l):\ %tote:\ %m,
                         %-G%\\s%#and,%-G%\\s%#with,%-G%\\s%#[,%-G%\\s%#%s=%m,%-G%\\s%#]
