syn match GTestOk "\[       OK \].\+"
syn match GTestPassed "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"
syn match GTestError " error: .\+"

syn match MSBuildError "error [A-Z0-9]\+:.\+$"
syn match MSBuildWarning "warning [A-Z0-9]\+:.\+$"
syn match MSBuildNote "note:.\+$"
