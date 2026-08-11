syn match GTestOk "\[       OK \].\+"
syn match GTestPassed "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"
syn match GTestError " error: .\+"
syn match GTestNote "   Actual:.\+$"
syn match GTestNote " Expected:.\+$"
syn match GTestNote "     Which is:.\+$"
syn match GTestNote "   .\+$"
syn match GTestNote "	.\+$"

syn match MSBuildError "error [A-Z0-9]\+:.\+$"
syn match MSBuildError "error [A-Z0-9]\+:.\+$" contained containedin=qfLineNr,qfText
syn match MSBuildWarning "warning [A-Z0-9]\+:.\+$"
syn match MSBuildWarning "warning [A-Z0-9]\+:.\+$" contained containedin=qfLineNr,qfText
syn match MSBuildInfo "info [A-Z0-9]\+:.\+$"
syn match MSBuildInfo "info [A-Z0-9]\+:.\+$" contained containedin=qfLineNr,qfText
syn match MSBuildNote "note:.\+$"
syn match MSBuildNote "note:.\+$" contained containedin=qfLineNr,qfText
syn match MSBuildNone "    Creating library.\+$"
syn match MSBuildNone "    Creating library.\+$" contained containedin=qfLineNr,qfText

syn match ITestError "\<FAILED\>"
syn match ITestError "\<FAILED\>" contained containedin=qfLineNr,qfText
syn match ITestWarning "\<SKIPPED\>"
syn match ITestWarning "\<SKIPPED\>" contained containedin=qfLineNr,qfText
syn match ITestSuccess "\<PASSED\>"
syn match ITestSuccess "\<PASSED\>" contained containedin=qfLineNr,qfText
