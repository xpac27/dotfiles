" Show variable types
let g:lsp_inlay_hints_enabled = 0

" Highlight the word under cursor
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_highlight_delay = 150

" Improve syntax higlight
let g:lsp_semantic_enabled = 1

" Enables floating window documentation for complete items
let g:lsp_completion_documentation_enabled = 0
let g:lsp_completion_documentation_delay = 99999999

" Closes the preview window on the second call to preview
let g:lsp_preview_doubletap = [function('lsp#ui#vim#output#closepreview')]

" Diagnostics
let g:lsp_diagnostics_echo_cursor = 1 " show diags in the status line
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_float_cursor = 0 " show diags in a popup
let g:lsp_diagnostics_float_insert_mode_enabled = 0 " show diags in a popup
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0 " show diags in a popup
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': '🔥'}
let g:lsp_diagnostics_signs_hint = {'text': '💡'}
let g:lsp_diagnostics_signs_information = {'text': 'ℹ️'}
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_diagnostics_signs_insert_mode_enabled = 1 " Please don't bother me while I type
let g:lsp_diagnostics_signs_warning = {'text' : '🌩️'}
let g:lsp_diagnostics_virtual_text_align = 'after' " 'after' or 'below'
let g:lsp_diagnostics_virtual_text_delay = 200
let g:lsp_diagnostics_virtual_text_enabled = 1 " show diags inlined
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_virtual_text_wrap = 'wrap'

" Code actions
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_code_action_signs_hint = {'text': '🪓'}

" Autocomplete signature
let g:lsp_signature_help_enabled = 1

" Should improve perfs
let g:lsp_use_lua = has('nvim-0.4.0') || (has('lua') && has('patch-8.2.0775'))
let g:lsp_use_native_client = 1

" Signs
hi LspWarningText guibg=NONE
hi LspErrorText guibg=NONE
hi LspInformationText guibg=NONE
hi LspHintText guibg=NONE

" Text
hi link LspWarningHighlight Warning
hi link LspErrorHighlight Error
hi link LspInformationHighlight Visual
hi link LspHintHighlight Visual

" Message
hi link LspWarningVirtualText WarningMsg
hi link LspErrorVirtualText ErrorMsg
hi link LspInformationTextVirtualText Visual
hi link LspHintVirtualText Visual

highlight link lspReference CurrentWord

function! s:on_lsp_buffer_enabled() abort
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> gd :LspDefinition<CR>
    nmap <buffer> gD :LspTypeDefinition<CR>

    nmap <buffer> gS :LspDocumentSymbolSearch<CR>
    nmap <buffer> gs :LspWorkspaceSymbolSearch<CR>

    nmap <buffer> gr :LspReferences<CR>

    nmap <buffer> [g :LspPreviousDiagnostic<CR>
    nmap <buffer> ]g :LspNextDiagnostic<CR>
    nmap <buffer> gi :LspDocumentDiagnostics<CR>

    nmap <buffer> gh :LspTypeHierarchy<CR>

    nmap <buffer> ga :LspCodeAction --ui=float<CR>

    nmap <buffer> K :LspHover<CR>

    nnoremap <buffer> <leader>h :LspDocumentSwitchSourceHeader<CR>
    nnoremap <buffer> <Right> :LspNextDiagnostic<CR>
    nnoremap <buffer> <Left> :LspPreviousDiagnostic<CR>

   if has("unix") && filereadable('.clang-format')
        let g:lsp_format_sync_timeout = 1000
        autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
   endif
endfunction

" Use windows clangd matching the version of clang mentioned in compile_commands.json
if has('win64') || has('win32')
    let g:lsp_settings = {
    \    'clangd': {
    \      'cmd': ['D:\packages\PCClang\17.0.6_20186251\installed\bin\clangd.exe', '--all-scopes-completion=0', '--header-insertion=never', '--rename-file-limit=100'],
    \      'allowlist': ['c', 'cpp'],
    \      'blocklist': ['json'],
    \    },
    \    'efm-langserver': {'disabled': v:false},
    \  }
else
    let g:lsp_settings = {
    \    'clangd': {
    \      'cmd': ['clangd', '--completion-style=bundled', '--all-scopes-completion=0', '--function-arg-placeholders=1', '--header-insertion-decorators']
    \    },
    \    'efm-langserver': {'disabled': v:false}
    \  }
endif

" let g:lsp_settings_filetype_ruby = 'solargraph'

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
