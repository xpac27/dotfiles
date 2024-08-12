syn match GTestOk "\[       OK \].\+"
syn match GTestOk "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"

syn match MSBuildError "error [A-Z][0-9]\+:.\+$"
syn match MSBuildWarning "warning [A-Z][0-9]\+:.\+$"
