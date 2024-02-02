augroup QuickFixSyntax
	autocmd!
	autocmd Syntax qf syntax match MSBuildError "error [A-Z0-9]\+:.\+$"
	autocmd Syntax qf syntax match MSBuildWarning "warning [A-Z0-9]\+:.\+$"
augroup end

hi link MSBuildError ErrorMsg
hi link MSBuildWarning WarningMsg
