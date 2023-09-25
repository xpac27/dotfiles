augroup ftdetect_cpp
	autocmd!

	au BufRead *.cpp,*.hpp setlocal ft=cpp
	au BufRead *.h if search('\(namespace\|class\)', 'n') | setlocal ft=cpp | endif
	au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif
augroup END
