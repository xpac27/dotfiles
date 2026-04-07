syn match GTestOk "\[       OK \].\+"
syn match GTestPassed "\[  PASSED  \].\+"
syn match GTestFailed "\[  FAILED  \].\+"
syn match GTestError " error: .\+"
syn match GTestNote "   Actual:.\+$"
syn match GTestNote " Expected:.\+$"
syn match GTestNote "     Which is:.\+$"
syn match GTestNote "   .\+$"
syn match GTestNote "\t.\+$"

runtime syntax/qf-common.vim

syn match qfTestNameSuccess "\S\+\ze\s\+PASSED\>" containedin=ALL contains=NONE
syn match qfTestNameError "\S\+\ze\s\+FAILED\>" containedin=ALL contains=NONE
syn match qfTestNameWarning "\S\+\ze\s\+SKIPPED\>" containedin=ALL contains=NONE
syn match qfTiming "took .*$" contains=NONE

" Semantic test result keywords inside the parsed output.
syn match ITestSuccess "\<PASSED\>"
syn match ITestError "\<FAILED\>"
syn match ITestWarning "\<SKIPPED\>"
syn match TestFailed "\<FAIL\>"

syn match ClangError "\<error:.*$" containedin=ALL contains=NONE
syn match ClangWarning "\<warning:.*$" containedin=ALL contains=NONE
syn match ClangNote "\<note:.*$" containedin=ALL contains=NONE
syn match ClangCodeLine "^\s\+\d\+\s|\s.*$" contains=NONE
syn match ClangPointerLine "^\s*|\s*[\^~;].*$" contains=NONE
syn match ClangSummaryError "\<\d\+\s\+error\%[s]\?\s\+generated\.\>"
syn match ClangSummaryWarning "\<\d\+\s\+warning\%[s]\?\s\+\%(and\s\+\d\+\s\+error\%[s]\?\s\+\)\?generated\.\>"
syn match NinjaBuildStep "^\[\d\+/\d\+\].*$"
syn match NinjaFailure "^FAILED:.*$"
syn match NinjaInfo "^ninja: Entering directory .*$"
syn match NinjaStopped "^ninja:\s\+build stopped:.*$"

syn match MSBuildError '\c\<error [A-Z0-9]\+:.*$' containedin=ALL contains=NONE
syn match MSBuildWarning '\c\<warning [A-Z0-9]\+:.*$' containedin=ALL contains=NONE
syn match MSBuildInfo '\c\<info [A-Z0-9]\+:.*$' containedin=ALL contains=NONE
syn match MSBuildNone '    Creating library.\+$' containedin=ALL contains=NONE
syn match MSBuildNote '\c\<note:.*$' containedin=ALL contains=NONE
