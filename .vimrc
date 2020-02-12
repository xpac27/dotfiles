" Automatic installation of vim-plug
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
	Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
	Plug 'nfvs/vim-perforce'
	Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }
	Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
	Plug 'skywind3000/vim-terminal-help'
	Plug 'vim-scripts/a.vim'
end

Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] } 
Plug 'sheerun/vim-polyglot'
Plug 'shinchu/lightline-gruvbox.vim'

call plug#end()

filetype on
syntax enable

set autoread
set background=dark
set backspace=indent,eol,start
set backup
set backupdir=~/.cache/vim/backup
set backupskip+=",*.gpg"
set cmdheight=1
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
set tags=./tags,.tags
set textwidth=99999
set timeoutlen=300
set undodir=~/.cache/vim/undo
set undofile
set undolevels=1000
set undoreload=1000
set updatetime=300
set wildignore=*.o,*.so,*.pyc,*.swp,*.orig,DS_Store
set wildmenu
set wildmode=longest,list
set writebackup

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

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" better lambda indent
au BufNewFile,BufRead *.cpp setlocal cindent cino='j1,(0,ws,Ws'

" Auto save
" au CursorHold *.c,*.h,*.cpp,*.h,*.hpp,*.rb nested silent up

" Auto open quickfix on make
" au QuickFixCmdPost [^l]* nested cwindow
" au QuickFixCmdPost l* nested lwindow

" Check spelling in markdown files
au FileType markdown setlocal spell

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




" =========================================================================
" COMMANDS
" =========================================================================


" JSON
" -------------------------------------------------------------------------
if executable('python')
    command! JSON :%!python -m json.tool
endif


" Async MAKE
" -------------------------------------------------------------------------
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>




" =========================================================================
" PLUGINS
" =========================================================================


" Gruvbox
" -------------------------------------------------------------------------
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_italic=0
let g:gruvbox_invert_selection=0
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_vert_split="bg0"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_color_column="bg0"
colorscheme gruvbox
" hi VertSplit guifg=#504945
hi ColorColumn guibg=#1d2021
" hi Search guifg=#666666 guibg=#ffffff
hi CocHighlightText guibg=#665c54


" AsyncRun
" -------------------------------------------------------------------------
let g:asyncrun_open = 12
let g:asyncrun_save = 2
let g:asyncrun_local = 1
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


" Clang Format
" -------------------------------------------------------------------------
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#enable_fallback_style = 0


" FZF
" -------------------------------------------------------------------------
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" CTRL-Q to open in quickfix list
let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" CTRL-A to select all
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--bind=ctrl-a:select-all']}, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.<q-args>, 1, fzf#vim#with_preview({'options': ['--bind=ctrl-a:select-all']}), <bang>0)

nmap <leader>f :Files<CR>
nmap <leader>g :Rg 

let g:fzf_tags_command = 'ctags -R --extra=+q'


" A
" -------------------------------------------------------------------------
let g:alternateRelativeFiles = 1
nmap <Leader>h :A<CR>


" NERDCommenter
" -------------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'ddf': { 'left': '//','right': '' } }


" Perforce
" -------------------------------------------------------------------------
let g:perforce_prompt_on_open=0
let g:perforce_open_on_change=1


" CRTLSF
" -------------------------------------------------------------------------
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_search_mode = 'async'


" COC
" -------------------------------------------------------------------------
let languageservers = {}

let languageservers['clangd'] = {
    \ 'command': 'clangd',
    \ 'filetypes': ['c', 'cpp'],
    \ 'rootPatterns': ['compile_commands.json', '.vim/', '.git/', '.hg/', 'TNT.proj'],
\ }

" let languageservers['ccls'] = {
    " \ 'command': 'ccls',
    " \ 'filetypes': ['c', 'cpp'],
    " \ 'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
    " \ 'initializationOptions': {
    " \   'cache': {
    " \     'directory': '/home/vinz/.cache/ccls',
    " \ 	}
    " \ }
" \ }

let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-snippets',
\]

let g:coc_user_config = {
    \ 'coc.preferences.formatOnSaveFiletypes': [],
    \ 'diagnostic.enable': v:true,
    \ 'diagnostic.enableMessage': 'always',
    \ 'languageserver': languageservers,
    \ 'diagnostic.errorSign': 'x',
    \ 'diagnostic.warningSign': '∆',
    \ 'diagnostic.infoSign': '➤',
    \ 'diagnostic.hintSign': '➤',
    \ 'suggest.snippetIndicator': ' ⚡',
\ }

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

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
            break
        endif
        let dirname = fnamemodify(dirname, ":p:h:h")
    " endwhile
endfunction

call SetLocalOptions(bufname("%"))
