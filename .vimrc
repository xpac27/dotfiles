" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif




" =========================================================================
" PLUGINS
" =========================================================================


call plug#begin('~/.vim/plugged')


" Magic
" -------------------------------------------------------------------------
Plug 'valloric/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': './install.py --clang-completer --system-libclang' }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'


" Misc:
" -------------------------------------------------------------------------

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
Plug 'jamessan/vim-gnupg'
Plug 'wgurecky/vimSum'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/tComment'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-eunuch', { 'on' : ['Delete', 'Unlink', 'Move', 'Rename', 'Find'] }
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }


" Search
" -------------------------------------------------------------------------

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'


" Interfaces
" -------------------------------------------------------------------------

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'gcmt/taboo.vim'
Plug 'scrooloose/nerdtree', { 'on' : ['NERDTreeToggle'] }
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'


" Schemes
" -------------------------------------------------------------------------

Plug 'morhetz/gruvbox'


" Syntaxes
" -------------------------------------------------------------------------

Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'jeroenbourgois/vim-actionscript'
Plug 'yaymukund/vim-rabl'
Plug 'groenewege/vim-less'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-haml'


call plug#end()
filetype on
syntax enable


packadd termdebug


" =========================================================================
" SETTINGS
" =========================================================================


set path=.,,**,/usr/local/include,/usr/include
set tags=./tags,.tags
set enc=utf-8
set spelllang=en_us
set fileformats=unix,dos,mac
set fillchars=vert:┃ 
set visualbell t_vb=
set sessionoptions+=tabpages,globals
set viminfo=!,'100,h,n~/.viminfo
set history=1000
set undodir=~/.cache/vim/undo
set backupdir=~/.cache/vim/backup
set backupskip+=",*.gpg"
set textwidth=99999
set tabpagemax=999
set showtabline=1
set laststatus=2
set titlestring=(\ %(%{&ft},\ %)%{&ff}%(,\ %{&fenc}%)\ )
set titlelen=100
set mouse-=a
set complete-=i
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
set wildmode=longest,list
set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc,*.pump
set cmdheight=1
set report=999999
set shortmess=IAW
set scrolloff=5
set scrolljump=5
set softtabstop=4
set shiftwidth=4
set tabstop=4
set updatetime=250
set timeoutlen=300
set maxmem=2000000
set maxmemtot=2000000
set backspace=indent,eol,start
set pumheight=15
set rtp+=/usr/local/opt/fzf
set csto=0
set cspc=0
set nocsverb

set nocompatible
set noswapfile
set noerrorbells
set novisualbell
" set nobackup
" set nowritebackup
set backup
set writebackup
set nolist
set nowrap
set noshowmode
set noruler
set noequalalways

set hidden
set ttyfast
set lazyredraw
set autoread
set number
set relativenumber
set cursorline
set title
set wildmenu
set mousehide
set smarttab
set expandtab
set shiftround
set smartindent
set splitbelow
set splitright
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set gdefault
set cst
set undofile

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
" let g:netrw_altv=1          " open splits to the right
" let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if &diff
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
end



" =========================================================================
" AUTO COMMANDS
" =========================================================================


" use tabs in Makefile
au BufNewFile,BufRead Makefile setlocal noexpandtab

" better lambda indent
au BufNewFile,BufRead *.cpp setlocal cindent cino='j1,(0,ws,Ws'

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" force actionscript on .as files
au BufNewFile,BufRead *.as set ft=actionscript

" activate FileSwitch on cpp and h files
au! BufEnter *.cpp let b:fswitchdst = 'hpp'  | let b:fswitchlocs = './,../inc/,../../inc/,../inc/**/,../../inc/**/,../include/,../include/**/,../../include/,../../include/**/,../../../include/,../../../include/**/,../../../../include/,../../../../include/**/,../../../../../include/,../../../../../include/**/'
au! BufEnter *.hpp let b:fswitchdst = 'cpp'  | let b:fswitchlocs = './,../src/,../../src/,../src/**/,../../src/**/,../source/,../source/**/,../../source/,../../source/**/,../../../source/,../../../source/**/,../../../../source/,../../../../source/**/,../../../../../source/,../../../../../source/**/'
au! BufEnter *.c   let b:fswitchdst = 'h'    | let b:fswitchlocs = './,../inc/,../../inc/,../inc/**/,../../inc/**/,../include/,../include/**/,../../include/,../../include/**/,../../../include/,../../../include/**/,../../../../include/,../../../../include/**/,../../../../../include/,../../../../../include/**/'
au! BufEnter *.h   let b:fswitchdst = 'c'    | let b:fswitchlocs = './,../src/,../../src/,../src/**/,../../src/**/,../source/,../source/**/,../../source/,../../source/**/,../../../source/,../../../source/**/,../../../../source/,../../../../source/**/,../../../../../source/,../../../../../source/**/'

" Auto save
" au CursorHold *.cpp,*.h,*.hpp,*.rb nested silent up

" Make crontab happy
au filetype crontab setlocal nobackup nowritebackup

" Auto open quickfix on make
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

" Change default tab settings
au Filetype ruby,yaml setlocal ts=2 sts=2 sw=2

" Check file for changes
au CursorHold * :checktime




" =========================================================================
" MAPPINGS
" =========================================================================


" typos
ia   feild    field
ia   flase    false
ia   lenght   length
ia   toogle   toggle
ia   wiht     with
ia   heigth   height
ia   retrun   return
ia   being    begin

" shortcuts
ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public

" save time
nnoremap ; :

" select the current line without indentation
nnoremap vv ^vg_

" don't lose selection after indenting
vnoremap < <gv
vnoremap > >gv

" Clear search
nnoremap <silent> _ :nohl<CR>

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" toggle options
nnoremap <silent> <leader>op :set paste!<CR>
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>os :setl spell!<CR>
nnoremap <silent> <leader>od :e ++ff=dos<CR>:setlocal ff=dos<CR>

" tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" copy/past word
noremap <unique> <Leader>y viw"wy
noremap <unique> <Leader>p viw"wp

" Compile
map <Leader>m :AsyncRun make compile<CR>
map <Leader>c :AsyncStop<CR>
map <Leader>C :AsyncStop!<CR>

" Close QuickFix window
nmap <leader>c :cclose<CR>

" Avoid unintentional switches to Ex mode.
nmap Q q

" Not usefull
nmap K <nop>
nmap <C-s> <nop>
nmap ^S <nop>

 " Repurpose cursor keys
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :lprevious<CR>
nnoremap <silent> <Right> :lnext<CR>




" =========================================================================
" PLUGINS
" =========================================================================


" FZF
" -------------------------------------------------------------------------
if executable('rg')
  command! -complete=dir -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.<q-args>, 1, <bang>0)
endif


" FSwitch
" -------------------------------------------------------------------------
nmap <silent> <Leader>s  :up<CR>:FSHere<cr>


" Gruvbox
" -------------------------------------------------------------------------
set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_italic=0
let g:gruvbox_invert_selection=0
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="hard"
let g:gruvbox_vert_split="bg0"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_color_column="bg0"
let g:gruvbox_vert_split="bg0"
set background=dark
colorscheme gruvbox
hi VertSplit guifg=#504945
hi Search guifg=#666666 guibg=#ffffff


" Ultisnips
" -------------------------------------------------------------------------
" YouCompleteMe and UltiSnips compatibility.
let g:UltiSnipsExpandTrigger = '<Right>'
let g:UltiSnipsJumpForwardTrigger = '<Right>'
let g:UltiSnipsJumpBackwardTrigger = '<Left>'


" YouCompleteMe
" -------------------------------------------------------------------------
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_always_populate_location_list = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_echo_current_diagnostic = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_filetype_blacklist = {'vim' : 1, 'ruby': 1}
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" let g:ycm_key_list_accept_completion = ['<C-y>']
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1 }
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '∆'
autocmd FileType c,cpp nnoremap <silent> <SPACE> :ClangFormat<CR>zz:silent YcmForceCompileAndDiagnostics<CR>:GitGutterAll<CR>
autocmd FileType c,cpp nnoremap <silent> <Leader>f :YcmCompleter FixIt<CR>:ccl<CR>
autocmd FileType c,cpp nnoremap <silent> <Leader>g :YcmCompleter GetType<CR>


" T-Comment
" -------------------------------------------------------------------------
nnoremap <C-c> :TComment<CR>j
vnoremap <C-c> :TComment<CR>j


" Clang-Format
" -------------------------------------------------------------------------
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_format = 0
let g:clang_format#detect_style_file = 1


" Git-Gutter
" -------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_realtime =1
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed= '·'
let g:gitgutter_sign_modified_removed= '·'
" hi GitGutterAdd ctermbg=234 ctermfg=238
" hi GitGutterDelete ctermbg=234 ctermfg=238
" hi GitGutterChange ctermbg=234 ctermfg=238
" hi GitGutterChangeDelete ctermbg=234 ctermfg=238


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
      \ 'colorscheme': 'PaperColor',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'arrow_right', 'paste' ], [ 'relativepath', 'modified', 'readonly' ] ],
      \   'right': [ [ 'percent' ], [ 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'readonly', 'relativepath' ] ],
      \   'right': [ ]
      \ },
      \ 'component': {
      \   'arrow_right': '  '
      \ },
\ }


" LSP
" -------------------------------------------------------------------------

if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/home/vinz/.cache/cquery' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

autocmd FileType c,cpp nnoremap <silent> <leader>d :LspDefinition<CR>
autocmd FileType c,cpp nnoremap <silent> <leader>e :LspReferences<CR>
autocmd FileType c,cpp nnoremap <silent> <leader>t :LspTypeDefinition<CR>
autocmd FileType c,cpp nnoremap <silent> <leader>r :LspRename<CR>




" =========================================================================
" LOCAL VIMRC
" =========================================================================

function SetLocalOptions(fname)
    let dirname = fnamemodify(a:fname, ":p:h")
    while "/" != dirname
        let lvimrc  = dirname . "/.lvimrc"
        if filereadable(lvimrc)
            execute "source " . lvimrc
            break
        endif
        let dirname = fnamemodify(dirname, ":p:h:h")
    endwhile
endfunction

call SetLocalOptions(bufname("%"))
