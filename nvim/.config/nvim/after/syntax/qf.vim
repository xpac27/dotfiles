syn match GTestOk "\[       OK \].\+"
syn match GTestPassed "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"
syn match GTestError " error: .\+"
syn match GTestNote "   Actual:.\+$"
syn match GTestNote " Expected:.\+$"
syn match GTestNote "     Which is:.\+$"
syn match GTestNote "   .\+$"
syn match GTestNote "	.\+$"

" Quickfix entry structure: path on the left, parsed output on the right.
syn match qfPath "^[^|]\+\ze\s|\s" contains=qfError
syn match qfSeparator "\s|\s" contains=NONE
syn match qfTestNameSuccess "\s|\s\zs.\{-}\ze\s\+PASSED\>" contains=NONE
syn match qfTestNameError "\s|\s\zs.\{-}\ze\s\+FAILED\>" contains=NONE
syn match qfTestNameWarning "\s|\s\zs.\{-}\ze\s\+SKIPPED\>" contains=NONE
syn match qfTiming "took .*$" contains=NONE

" Semantic test result keywords inside the parsed output.
syn match ITestSuccess "\<PASSED\>"
syn match ITestError "\<FAILED\>"
syn match ITestWarning "\<SKIPPED\>"
syn match TestFailed "\<FAIL\>"

syn match MSBuildError ".*\\cerror [A-Z0-9]\\+:.*$"
syn match MSBuildWarning ".*\\cwarning [A-Z0-9]\\+:.*$"
syn match MSBuildInfo ".*\\cinfo [A-Z0-9]\\+:.*$"
syn match MSBuildNone "    Creating library.\+$"
syn match MSBuildNote ".*\\cnote:.*$"
