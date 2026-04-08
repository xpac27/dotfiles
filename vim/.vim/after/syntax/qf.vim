syn match GTestOk "\[       OK \].\+" contained containedin=qfText
syn match GTestPassed "\[  PASSED  \].\+" contained containedin=qfText
syn match GTestFailed "\[  FAILED  \].\+" contained containedin=qfText
syn match GTestError " error: .\+" contained containedin=qfText
syn match GTestNote "   Actual:.\+$" contained containedin=qfText
syn match GTestNote " Expected:.\+$" contained containedin=qfText
syn match GTestNote "     Which is:.\+$" contained containedin=qfText
syn match GTestNote "   .\+$" contained containedin=qfText
syn match GTestNote "	.\+$" contained containedin=qfText

syn match TestFailed "FAIL .\+" contained containedin=qfText

syn match MSBuildError "error [A-Z0-9]\+:.\+$" contained containedin=qfText
syn match MSBuildWarning "warning [A-Z0-9]\+:.\+$" contained containedin=qfText
syn match MSBuildInfo "info [A-Z0-9]\+:.\+$" contained containedin=qfText
syn match MSBuildNote "note:.\+$" contained containedin=qfText
syn match MSBuildNone "    Creating library.\+$" contained containedin=qfText

syn match ITestError " .\+ FAILED" contained containedin=qfText
syn match ITestWarning " .\+ SKIPPED" contained containedin=qfText
syn match ITestSuccess " .\+ PASSED" contained containedin=qfText
