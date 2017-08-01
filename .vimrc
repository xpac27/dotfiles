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


" Misc:
" -------------------------------------------------------------------------

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'skywind3000/asyncrun.vim'
Plug 'jamessan/vim-gnupg'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/tComment'
Plug 'rhysd/vim-clang-format'
Plug 'breuckelen/vim-resize'
Plug 'godlygeek/tabular', { 'on': 'Tabularize'}


" Search
" -------------------------------------------------------------------------

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', 'GrepperGit', 'GrepperAg', '<plug>(GrepperOperator)'] }
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/CmdlineComplete'


" Interfaces
" -------------------------------------------------------------------------

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpen' }
Plug 'airblade/vim-gitgutter'
Plug 'gcmt/taboo.vim'


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




" =========================================================================
" SETTINGS
" =========================================================================


set path=.,,**,/usr/local/include,/usr/include
set tags=./tags,.tags,.git/tags
set enc=utf-8
set spelllang=en_us
set fileformats=unix,dos,mac
set visualbell t_vb=
set sessionoptions+=tabpages,globals
set viminfo=!,'100,h,n~/.viminfo
set history=1000
set undodir=~/.vim/undofiles
set textwidth=99999
set tabpagemax=999
set showtabline=1
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
set statusline=%f\ %r%m%=\ %P\ -\ %c:%l/%L
set errorformat+=%f:%l:%c:\ %t:\ %m
set errorformat+=%f(%l\\\,%c):%m
set errorformat+=\ %f(%l\\\,%c):%m
set errorformat+=%f:%l\\\,%c:%m
set errorformat+=\ %f:%l\\\,%c:%m
set errorformat+=%f:%l:%m
set errorformat+=\ %f:%l:%m
set csto=0
set cspc=0
set nocsverb
if filereadable(".git/cscope.out")
    cs add .git/cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

set nocompatible
set noswapfile
set noerrorbells
set novisualbell
set nobackup
set nowritebackup
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
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'




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
au! BufEnter *.cpp,*.cc let b:fswitchdst = 'hpp,h'  | let b:fswitchlocs = './,../inc/,../../inc/,../inc/**/,../../inc/**/,../include/,../include/**/,../../include/,../../include/**/,../../../include/,../../../include/**/,../../../../include/,../../../../include/**/,../../../../../include/,../../../../../include/**/'
au! BufEnter *.h,*.hpp  let b:fswitchdst = 'cpp,cc' | let b:fswitchlocs = './,../src/,../../src/,../src/**/,../../src/**/,../source/,../source/**/,../../source/,../../source/**/,../../../source/,../../../source/**/,../../../../source/,../../../../source/**/,../../../../../source/,../../../../../source/**/'

" Auto save
au CursorHold *.cpp,*.h,*.hpp,*.rb nested silent w

" Make crontab happy
au filetype crontab setlocal nobackup nowritebackup

" Auto open quickfix on make
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

" Change default tab settings
au Filetype ruby,yaml setlocal ts=2 sts=2 sw=2




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
ia   jeugo    juego
ia   Jeugo    Juego

" shortcuts
ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public

" Don't move around with arrows
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" save time
nnoremap ; :
nnoremap q: :q

" disable hex mode
nnoremap Q <Nop>

" select the current line without indentation
nnoremap vv ^vg_

" don't lose selection after indenting
vnoremap < <gv
vnoremap > >gv

" clear searches
nnoremap <ESC><ESC> :nohlsearch<CR>

" toggle options
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>os :setl spell!<CR>
nnoremap <silent> <leader>od :e ++ff=dos<CR>:setlocal ff=dos<CR>

" tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" Replace word under cursor
nnoremap <leader>r :%s/\<<C-R><C-W>\>//gc<left><left><left>

" duplication
nnoremap <silent> <LocalLeader>t YP

" copy/past word
noremap <unique> <Leader>y viw"wy
noremap <unique> <Leader>p viw"wp

" Compile/test
map <Leader>m :AsyncRun make compile<CR>
map <Leader>t :AsyncRun make test<CR>

" Cscope
nmap <leader>x :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>




" =========================================================================
" PLUGINS
" =========================================================================


" FZF
nmap <C-f> :GitFiles<CR>
nmap <C-F> :Files<CR>

" Gruvebox
" -------------------------------------------------------------------------
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast_light="hard"
let g:gruvbox_vert_split="bg2"
set background=dark
colorscheme gruvbox


" UndoTree
" -------------------------------------------------------------------------
nnoremap <silent> <F3> :silent UndotreeToggle<CR>
inoremap <silent> <F3> <ESC>:silent UndotreeToggle<CR>


" Ale
" -------------------------------------------------------------------------
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '∆'
let g:ale_echo_cursor = 1
let g:ale_linters = {
\   'cpp': [],
\   'ruby': ['rubocop'],
\   'bash': ['shellcheck'],
\   'css': ['csslint'],
\   'javascript': ['jshint'],
\   'sass': ['sass-lint'],
\   'coffeescript': ['coffee'],
\   'yaml': ['yamllint'],
\}
hi ALEWarningSign ctermbg=214 ctermfg=214
hi ALEErrorSign ctermbg=167 ctermfg=167


" Ultisnips
" -------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsListSnippets = "<C-Tab>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
inoremap <c-x><c-k> <c-x><c-k>


" YouCompleteMe
" -------------------------------------------------------------------------
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_echo_current_diagnostic = 1
let g:ycm_filetype_blacklist = {'vim' : 1, 'ruby': 1}
let g:ycm_key_list_select_completion=['<Tab>', '<Down>']
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '∆'
hi YcmErrorLine guibg=#4f2626
hi YcmWarningLine guibg=#4f4f26
nnoremap <silent> <Leader>f :YcmCompleter FixIt<CR>:ccl<CR>
nnoremap <silent> <Leader>g :YcmCompleter GetType<CR>
nnoremap <silent> <leader>d :YcmCompleter GoTo<CR>
nnoremap <silent> <SPACE> :silent YcmForceCompileAndDiagnostics<CR>:GitGutterAll<CR>


" T-Comment
" -------------------------------------------------------------------------
nnoremap <C-c> :TComment<CR>j
vnoremap <C-c> :TComment<CR>j


" Clang-Format
" -------------------------------------------------------------------------
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_format = 0
let g:clang_format#detect_style_file = 1
autocmd FileType cpp nmap <SPACE><SPACE> :%s/\s\+$//e<CR>:set nohlsearch<CR>:ClangFormat<CR>


" Git-Gutter
" -------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_realtime =1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed= '-'
let g:gitgutter_sign_modified_removed= '-'


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


" FSwitch
" -------------------------------------------------------------------------
nmap <silent> <Leader>s  :FSHere<cr>


" EasyMotion
" -------------------------------------------------------------------------
" Bidirection jump base on 2 chars
nmap s <Plug>(easymotion-s2)
" Jump to line
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Smart case
let g:EasyMotion_smartcase = 1


" Asyncrun
" -------------------------------------------------------------------------
let g:asyncrun_exit='copen 20'


" Taboo
" -------------------------------------------------------------------------
let g:taboo_tab_format = ' %f%m '




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
