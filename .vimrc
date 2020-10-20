if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

if &diff
else
	Plug 'dyng/ctrlsf.vim'
	Plug 'gcmt/taboo.vim'
	Plug 'jamessan/vim-gnupg'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	Plug 'mhinz/vim-startify'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'ycm-core/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': 'python install.py --clangd-completer' }
	Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }
	Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
	Plug 'derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }
    Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c'}
    Plug 'junegunn/goyo.vim'

    if has("unix")
    else
        Plug 'nfvs/vim-perforce'
    endif
end

if has("unix")
    Plug 'direnv/direnv.vim'
endif

Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
" Plug 'sheerun/vim-polyglot'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'gregsexton/MatchTag', { 'for': ['html'] }

call plug#end()

autocmd FileType c setl cms=//\ %s
filetype on
syntax enable

source $VIMRUNTIME/vimrc_example.vim

if exists('theme') && theme == 'light'
    set background=light
else
    set background=dark
endif

set autoread
set backspace=indent,eol,start
set cmdheight=2
set complete-=i
set completeopt=longest,menuone
set cryptmethod=blowfish2
set cursorline
set encoding=UTF-8
set equalalways
set expandtab
set fileformats=unix,dos,mac
set fillchars=vert:┃ 
set gdefault
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set mouse-=a
set mousehide
set noerrorbells
set nolist
set nomodeline " disabled for security
set noruler
set noshowmode
set noswapfile
set novisualbell
set nowrap
set number
set path=.,,**,/usr/local/include,/usr/include
set pumheight=15
set relativenumber
set scrolljump=5
set scrolloff=5
set shiftround
set shiftwidth=4
set shortmess=IAW
set showmatch
set showtabline=1
set sidescrolloff=5
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set softtabstop=4
set spelllang=en_us
set splitbelow
set splitright
set tabpagemax=999
set tabstop=4
set termguicolors
set tags=./tags,.tags,tags
set textwidth=99999
set timeoutlen=300
set undodir=~/.cache/vim/undo
set undofile
set undolevels=1000
set undoreload=1000
set updatetime=300
set wildignore=*.o,*.dwo,*.so,*.pyc,*.swp,*.orig,DS_Store
set wildmenu
set wildmode=longest,list

if has("unix")
    set nobackup
    set nowritebackup
else
    set backup
    set backupdir=~/.cache/vim/backup
    set backupskip+=",*.gpg"
    set writebackup
endif

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if &diff
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
end

" disable annoying banner
let g:netrw_banner=0

" Check file for changes
au CursorHold * :checktime

" use tabs in Makefile
au BufNewFile,BufRead Makefile setlocal noexpandtab

" Make crontab happy
au filetype crontab setlocal nobackup nowritebackup

" better lambda indent
au BufNewFile,BufRead *.cpp setlocal cindent cino='j1,(0,ws,Ws'

" Auto save
" au CursorHold *.c,*.h,*.cpp,*.h,*.hpp,*.rb nested silent up

" Auto open quickfix on make
" au QuickFixCmdPost [^l]* nested cwindow
" au QuickFixCmdPost l* nested lwindow

" Check spelling in markdown files
" au FileType markdown setlocal spell

" typos
ia   feild    field
ia   flase    false
ia   lenght   length
ia   toogle   toggle
ia   wiht     with
ia   heigth   height
ia   retrun   return
ia   easlt    eastl
ia   being    begin
ia   frist    first

" shortcuts
ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public
ab   st   static
ab   cl   console.log

" save time
nnoremap ; :

" don't lose selection after indenting
vnoremap < <gv
vnoremap > >gv

" Clear search
nnoremap <silent> _ :nohl<CR>

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Toggle options
nnoremap <silent> <leader>op :set paste!<CR>
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>os :setl spell!<CR>
nnoremap <silent> <leader>od :e ++ff=dos<CR>:setlocal ff=dos<CR>

" Not usefull
nmap Q q
nmap K <nop>
nmap <C-s> <nop>
nmap ^S <nop>

" Repurpose cursor keys
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :lprevious<CR>
nnoremap <silent> <Right> :lnext<CR>

" Replace word under cursor
nnoremap <leader>r :%s/\<<C-R><C-W>\>//gc<left><left><left>

" Close QuickFix window
nnoremap <leader>c :cclose<CR>

" Copy filepath
nmap cp :let @+ = expand("%")<cr>




" =========================================================================
" COMMANDS
" =========================================================================


" FSwitch
" -------------------------------------------------------------------------
nmap <Leader>h :FSHere<CR>


" JSON
" -------------------------------------------------------------------------
if executable('python')
    command! JSON :%!python -m json.tool
endif


" Others
" -------------------------------------------------------------------------
if has("unix")
    command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
else
    command! Compile AsyncRun compile.rb %:p
    command! CompileProject AsyncRun compile.rb %:p:h
    command! CompileSolution AsyncRun compile.rb
    command! RemoveFromMaster AsyncRun -silent compile.rb REMOVE_FROM_MASTER %:p
	command! DicePersistenceTests AsyncRun D:\kingston\dev\TnT\Local\Bin\Win64-Dll\release\Extension.DicePersistence.Test_Win64_release_Dll.exe
endif



" =========================================================================
" PLUGINS
" =========================================================================


" Gruvbox
" -------------------------------------------------------------------------
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_vert_split="bg0"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_color_column="bg0"
let g:gruvbox_invert_selection=0
let g:gruvbox_inverse=1
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_improved_strings=0   
let g:gruvbox_improved_warnings=1

colorscheme gruvbox
" hi VertSplit guifg=#504945
" hi Search guifg=#666666 guibg=#ffffff
" hi ColorColumn guibg=#1d2021
hi CocHighlightText guibg=#665c54
hi Search guibg=#ffffff guifg=#8ec07c


" AsyncRun
" -------------------------------------------------------------------------
let g:asyncrun_open = 12
let g:asyncrun_save = 2
let g:asyncrun_exit = "if g:asyncrun_code == 0 | cclose | endif"


" Startify
" -------------------------------------------------------------------------
let g:startify_files_number = 12
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 0
let g:startify_bookmarks = [ '~/.vimrc' ]
let g:startify_custom_header = [
        \ '',
        \ '',
        \ '',
        \ '',
        \ ]
let g:startify_list_order = [
        \ ['   Recently used files in the current directory:'],
        \ 'dir',
        \ ['   Sessions:'],
        \ 'sessions',
        \ ['   Bookmarks:'],
        \ 'bookmarks',
\ ]


" EasyMotion
" -------------------------------------------------------------------------
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1


" Taboo
" -------------------------------------------------------------------------
let g:taboo_tab_format = ' %f%m '


" NERDTree
" -------------------------------------------------------------------------
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=2


" Lightline
" -------------------------------------------------------------------------
      " \ 'colorscheme': 'PaperColor_light',
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'window_number', 'relativepath', 'modified', 'cocstatus' ], [ 'readonly', 'paste' ] ],
      \   'right': [ [],[],[ 'lineinfo', 'percent', 'filetype', 'fileencoding' ], [], [] ]
      \ },
      \ 'inactive': {
      \   'left': [ ['window_number' ], [ 'relativepath' ], [ 'readonly' ] ],
      \   'right': []
      \ },
      \ 'component': {
      \   'arrow_right': '  '
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
	  \   'window_number': 'WindowNumber', 
      \ },
\ }

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


" FZF
" -------------------------------------------------------------------------
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" https://minsw.github.io/fzf-color-picker/
if exists('theme') && theme == 'light'
    let fzf_gruvebox = ''
else 
    let fzf_gruvebox = 'fg:#a89984,bg:#282828,hl:#fabd2f,fg+:#fbf1c7,bg+:#282828,hl+:#fabd2f,info:#fbf1c7,prompt:#fb4934,pointer:#fbf1c7,marker:#d3869b,spinner:#fabd2f,header:#8ec07c'
endif

" CTRL-Q to open in quickfix list
let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" CTRL-A to select all
if has("unix")
	command! -bang -nargs=? GFiles call fzf#vim#files(<q-args>, {'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
else
    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case -tcpp -tcsharp -tddf -tproto -tbuild -g "Engine/**" -g "DICE/BattlefieldGame/**" -g "DICE/Casablanca/**" -g "DICE/Extensions/**"', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
    command! -bang -nargs=? -complete=dir FilesAll call fzf#vim#files(<q-args>, {'source': 'rg --files --smart-case', 'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}, <bang>0)
endif

if has("unix")
    nmap <leader>f :GitFiles<CR>
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all', '--color', fzf_gruvebox]}), <bang>0)
else
    nmap <leader>f :Files<CR>
	command! -bang -nargs=* -complete=dir Find call fzf#vim#grep('rg --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild -g "Engine/**" -g "DICE/BattlefieldGame/**" -g "DICE/Casablanca/**" -g "DICE/Extensions/**" '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--preview', 'python C:\\Users\\vcogne\\bin\\preview.py {}', '--preview-window', 'bottom:40%:noborder', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case -tcpp -tcsharp -tddf -tproto -tbuild -g "Engine/**" -g "DICE/BattlefieldGame/**" -g "DICE/Casablanca/**" -g "DICE/Extensions/**" '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--preview', 'python C:\\Users\\vcogne\\bin\\preview.py {}', '--preview-window', 'bottom:40%:noborder', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAll call fzf#vim#grep('rg --vimgrep --smart-case '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--preview', 'python C:\\Users\\vcogne\\bin\\preview.py {}', '--preview-window', 'bottom:40%:noborder', '--color', fzf_gruvebox]}, <bang>0)
	command! -bang -nargs=* -complete=dir FindAllFiles call fzf#vim#grep('rg --max-count=1 --vimgrep --smart-case '.<q-args>, 1, {'options': ['--bind=ctrl-a:select-all', '--preview', 'python C:\\Users\\vcogne\\bin\\preview.py {}', '--preview-window', 'bottom:40%:noborder', '--color', fzf_gruvebox]}, <bang>0)
endif

nmap <leader>b :Buffers<CR>
nmap <leader>g :Find 
nmap <leader>l :BLines

let g:fzf_tags_command = 'ctags -R --extra=+q'
let g:fzf_layout = { 'down': '~80%' }


" NERDCommenter
" -------------------------------------------------------------------------
autocmd FileType c,cpp,cs,ddf,proto setlocal commentstring=//\ %s
autocmd FileType tup setlocal commentstring=\"\ %s


" Perforce
" -------------------------------------------------------------------------
let g:perforce_prompt_on_open=0
let g:perforce_open_on_change=1


" CRTLSF
" -------------------------------------------------------------------------
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_search_mode = 'async'


" Polyglote
" -------------------------------------------------------------------------
let g:polyglot_disabled = ['markdown']


" Vimspector
" -------------------------------------------------------------------------
let g:vimspector_enable_mappings = 'HUMAN'
set mouse=a
set ttymouse=sgr


" Goyo
" -------------------------------------------------------------------------

function! s:goyo_enter()
    hi! link StatusLine GruvBoxBg0
    hi! link StatusLineNC GruvBoxBg0
endfunction

function! s:goyo_leave()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" YouCompleteMe
" -------------------------------------------------------------------------
" if has('win64') || has('win32')
"     set pythonthreehome=$HOME\\AppData\\Local\\Programs\\Python\\Python38
"     set pythonthreedll=$HOME\\AppData\\Local\\Programs\\Python\\Python38\\python38.dll
" endif
" let g:ycm_clangd_binary_path = 'clangd'
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_filetype_whitelist = {'cpp': 1, 'c': 1}
" let g:ycm_error_symbol = '🔥'
" let g:ycm_warning_symbol = '🔔'
" let g:ycm_enable_diagnostic_highlighting = 1
" let g:ycm_auto_hover = ''
" let g:ycm_always_populate_location_list = 0
" let g:ycm_filepath_completion_use_working_dir = 0
" nmap <silent> gD :YcmCompleter GoTo<CR>
" nmap <silent> gd :YcmCompleter GoToImprecise<CR>
" nmap <silent> gr :YcmCompleter GoToReferences<CR>
" nmap <silent> gF :YcmCompleter FixIt<CR>
" nmap <silent> gR :YcmCompleter RefactorRename 
" nmap K <plug>(YCMHover)

" if has("unix")
" 	if filereadable('.clang-format')
" 		au BufWritePre *.cpp,*.c,*.h,*.hpp :YcmCompleter Format
" 	endif
" endif

" augroup MyYCMCustom
"     autocmd!
"     autocmd FileType c,cpp let b:ycm_hover = {
"                 \ 'command': 'GetDoc',
"                 \ 'syntax': &filetype
"                 \ }
" augroup END

" COC
" -------------------------------------------------------------------------
let g:coc_global_extensions = [
  \ 'coc-git',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-snippets',
  \ 'coc-markdownlint',
\]

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>




" =========================================================================
" LOCAL VIMRC
" =========================================================================

function! SetLocalOptions(fname)
    let dirname = fnamemodify(a:fname, ":p:h")
    " while "/" != dirname
        let lvimrc  = dirname . "/.lvimrc"
        if filereadable(lvimrc)
            execute "source " . lvimrc
            " break
        endif
        let dirname = fnamemodify(dirname, ":p:h:h")
    " endwhile
endfunction

if has("unix")
    call SetLocalOptions(bufname("%"))
elseif filereadable(".lvimrc")
    execute "source .lvimrc"
endif
