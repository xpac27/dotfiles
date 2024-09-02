syn match GTestOk "\[       OK \].\+"
syn match GTestPassed "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"
syn match GTestError " error: .\+"

syn match TestFailed "FAIL .\+"

syn match MSBuildError "error [A-Z0-9]\+:.\+$"
syn match MSBuildWarning "warning [A-Z0-9]\+:.\+$"
syn match MSBuildInfo "info [A-Z0-9]\+:.\+$"
syn match MSBuildNote "note:.\+$"
