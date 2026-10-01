" Keep inlay hints and completion documentation hidden; K still opens hover help.
let g:lsp_inlay_hints_enabled = 0
let g:lsp_completion_documentation_enabled = 0

" Highlight references to the symbol under the cursor and enable semantic colors.
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_highlight_delay = 150
let g:lsp_semantic_enabled = 1

" A second preview request closes the preview window.
let g:lsp_preview_doubletap = [function('lsp#ui#vim#output#closepreview')]

" Keep diagnostic highlights and messages, but avoid signs and inline text
" interfering with Autoflip. Hide diagnostic highlights while typing.
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0

" Signature help conflicts with Copilot in Windows gVim.
let g:lsp_signature_help_enabled = !(has('win32') || has('win64'))

" Use Vim's native LSP transport; Lua support already defaults to autodetection.
let g:lsp_use_native_client = 1
let g:lsp_format_sync_timeout = 1000

" Text
hi link LspWarningHighlight Warning
hi link LspErrorHighlight Error
" Match Humdrum's diagnostic palette while keeping Error/Warning's transparent background.
hi LspInformationHighlight guifg=#99ffff guibg=NONE gui=undercurl guisp=#00afff ctermfg=153 ctermbg=NONE cterm=undercurl
hi LspHintHighlight guifg=#ffffcc guibg=NONE gui=undercurl guisp=#00afff ctermfg=153 ctermbg=NONE cterm=undercurl

highlight link lspReference CurrentWord

function! s:format_on_save() abort
    if &l:buftype !=# '' || empty(expand('%')) || index(['c', 'cpp'], &l:filetype) < 0
        return
    endif
    " Search from this file, not Vim's working directory. Recheck on each save
    " so renaming a buffer or adding/removing .clang-format takes effect.
    let l:search_path = escape(expand('%:p:h'), ' ,;') . ';'
    if !empty(findfile('.clang-format', l:search_path))
        LspDocumentFormatSync
    endif
endfunction

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

    if has('unix') && index(['c', 'cpp'], &l:filetype) >= 0
        " Clear only our hook for this buffer when another server attaches.
        augroup user_lsp_format_on_save
            autocmd! BufWritePre <buffer>
            autocmd BufWritePre <buffer> call <SID>format_on_save()
        augroup END
    endif
endfunction

function! s:hide_clangd_hover_linebreaks() abort
    if index(['c', 'cpp'], &filetype) < 0
        return
    endif

    let l:hover_servers = filter(lsp#get_allowed_servers(), 'lsp#capabilities#has_hover_provider(v:val)')
    if l:hover_servers !=# ['clangd']
        return
    endif

    let l:winid = lsp#internal#document_hover#under_cursor#getpreviewwinid()
    if type(l:winid) == v:t_number && winbufnr(l:winid) > 0
        call matchadd('Pmenu', '  \+$', 20, -1, {'window': l:winid})
    endif
endfunction

" vim-lsp-settings owns registration, including YAML roots, schemas and
" formatting defaults. Customize servers here instead of registering them again.
" Share matching/ranking across platforms; keep platform overrides below.
let g:lsp_settings = {
\    'clangd': {
\        'config': {
\            'filter': {'name': 'fuzzy'},
\            'sort': {'name': 'relevance', 'max': 2000, 'locality': v:true},
\        },
\    },
\    'typos-lsp': {
\        'disabled': v:false,
\        'allowlist': ['c', 'cpp', 'markdown', 'ruby'],
\    },
\ }

if has('win64') || has('win32')
    " Match the Windows clangd version to compile_commands.json's compiler.
    let g:lsp_settings['clangd']['cmd'] = ['E:\packages\PCClang\20.1.3_23462449\installed\bin\clangd.exe', '--clang-tidy', '--header-insertion=never', '--rename-file-limit=500', '--all-scopes-completion=false']
    let g:lsp_settings['clangd']['allowlist'] = ['c', 'cpp']
    let g:lsp_settings['typos-lsp']['cmd'] = ['D:\typos-lsp_0.1.36\typos-lsp.exe']
    let g:lsp_settings['typos-lsp']['allowlist'] = ['c', 'cpp', 'markdown']
    " These are server IDs; 'JSON' is not a vim-lsp-settings server name.
    let g:lsp_settings['vscode-json-language-server'] = {'disabled': v:true}
    let g:lsp_settings['json-languageserver'] = {'disabled': v:true}
else
    let g:lsp_settings['clangd']['cmd'] = ['clangd', '--clang-tidy', '--completion-style=bundled', '--function-arg-placeholders=1', '--header-insertion-decorators', '--all-scopes-completion=false']
endif

augroup lsp_install
    autocmd!
    " Apply navigation and save hooks when an LSP server attaches to this buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    autocmd User lsp_float_opened call s:hide_clangd_hover_linebreaks()
augroup END
