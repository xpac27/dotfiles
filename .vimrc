set nocompatible      " This must be first, because it changes other options as side effect
set ttyfast           " improve drawing
set lazyredraw        " do not redraw while running macros
set autoread          " detect file changes
set title             " change the terminal's title
set noequalalways     " do not auto resize closed and oppened splits
set pastetoggle=<F10> " toggle between paste and normal: for 'safer' pasting from keyboard
set timeoutlen=250    " Time to wait after ESC (default causes an annoying delay)
set tabpagemax=999    " let me tab as much as I want
set t_Co=256
set background=dark
set backup
set writebackup
set hidden      " The current buffer can be put to the background without writing to disk
set hlsearch    " highlight search
set ignorecase  " Do case in sensitive matching with
set smartcase   " be sensitive when there's a capital letter
set incsearch   " start searching imediatly
set fo+=o       " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r       " Do not automatically insert a comment leader after an enter
set fo-=t       " Do no auto-wrap text using textwidth (does not apply to comments)
set textwidth=0 " Don't wrap lines by default
set nowrap
set ffs=unix,dos
set enc=utf-8
set ww=b,s,<,>
set history=1000
set undolevels=1000
set maxmem=2000000
set maxmemtot=2000000
set scrolloff=3
set scrolljump=3
set splitbelow
set splitright
set wildmenu
set wildmode=longest,list      " At command line, complete longest common string, then list alternatives.
set backspace=indent,eol,start " more powerful backspacing
filetype plugin indent on      " Automatically detect file types.
set number                     " Line numbers
set showmatch                  " Show matching brackets.
set matchtime=5                " Bracket blinking.
set novisualbell               " No blinking
set noerrorbells               " No noise.
set laststatus=2               " Always show status line
set vb t_vb=                   " disable any beeps or flashes on error
set ruler                      " Show ruler
set showcmd                    " Display an incomplete command in the lower right corner of the Vim window
set mouse-=a                   " Disable mouse
set mousehide                  " Hide mouse after chars typed
set expandtab " Indent
set smarttab
set shiftround
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,elsif,when,while,do,for,switch,case
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set spell spelllang=en_us
set complete+=kspell

autocmd BufEnter *.vimrc  set nospell
autocmd BufEnter *.as  set nospell

colorscheme smyck
syntax on

ia   feild    field
ia   flase    false
ia   lenght   length
ia   toogle   toggle

ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public
ab   st   static
ab   cl   console.log

" save time
nnoremap ; :

" turn of search hightlight
nmap <silent> \/ :nohlsearch<CR>

" save file whether in insert or normal mode
inoremap <leader>s <c-o>:w<cr><esc>
nnoremap <leader>s :w<cr>

" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" Duplication
vnoremap <silent> <LocalLeader>= yP
nnoremap <silent> <LocalLeader>= YP

" Split line (opposite to S-J joining line)
nnoremap <silent> <C-J> gEa<CR><ESC>ew

" Session
let sessionman_save_on_exit = 1
noremap <unique> <Leader>ss :SessionSave<CR>
noremap <unique> <Leader>sl :SessionList<CR>
noremap <unique> <Leader>so :SessionOpen

" Copy past word
noremap <unique> <Leader>y viw"py
noremap <unique> <Leader>p viw"pp

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Make
nnoremap <unique> <Leader>m :!make<CR>

" Switch window
map <Tab> <C-w>

" Resize window
nnoremap <unique> <C-UP> 4<C-w>+
nnoremap <unique> <C-DOWN> 4<C-w>-
nnoremap <unique> <C-LEFT> 4<C-w><
nnoremap <unique> <C-RIGHT> 4<C-w>>

" YCM GoTo
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR>

" Macro
map <F2> @a

" Syntastic
let g:syntastic_actionscript_mxmlc_exe = 'fcshctl mxmlc -source-path=src '
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_error_symbol = 'xx'
let g:syntastic_warning_symbol = 'vv'
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['javascript'],
    \ 'passive_filetypes': ['c', 'cpp', 'java', 'xhtml']
\ }

" Command-T
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=10

" Airline
let g:airline_theme = 'badwolf'
let g:airline#extensions#branch#enabled = 0

" T Comment
nnoremap // :TComment<CR>j
vnoremap // :TComment<CR>j

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" Fugitive
nnoremap <leader>Gg :Ggrep<SPACE>
nnoremap <leader>Gd :Gdiff<cr>
" switch back to current file and closes fugitive buffer
nnoremap <leader>GD :diffoff!<cr><C-W>h:bd<cr>

" NerdTree
noremap <F5> :NERDTreeToggle<CR>

" FuzzyFinder
noremap <F6> :FufFile<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|jpg|png|gif|DS_Store|sassc|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|.*[/\\]$'
let g:fuf_ignoreCase = 1

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" force actionscript on as files
au BufNewFile,BufRead *.as set ft=actionscript

" set zimbu filetype
au! BufNewFile,BufRead *.zu setf zimbu

" local lvimrc
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

" CTAGS
set tags=./tags;/
" set tags+=~/.vim/tags/gl
" set tags+=~/.vim/tags/sfml
" set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/std

" YOU COMPLETE ME
" let g:ycm_collect_identifiers_from_tags_files = 0
" let g:ycm_confirm_extra_conf = 1
let g:ycm_global_ycm_extra_conf="~/.ycm_extra_conf.py"
let g:ycm_filetype_blacklist = {'vim' : 1}
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" ULTISNIPS
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

au BufNewFile,BufRead * call SetLocalOptions(bufname("%"))

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'L9'

" Big features
Plugin 'gmarik/vundle'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'scrooloose/syntastic'
Plugin 'valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Syntaxes
Plugin 'tpope/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'yaymukund/vim-rabl'
Plugin 'AndrewRadev/vim-eco'
Plugin 'groenewege/vim-less'

" Searching
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/Command-T'

" Formating
Plugin 'tpope/vim-endwise'
Plugin 'vim-scripts/tComment'
Plugin 'godlygeek/tabular'

" UI
Plugin 'bling/vim-airline'
Plugin 'gmarik/vim-visual-star-search'

call vundle#end()
filetype plugin indent on


" BACKUP 1
" Plugin 'Rip-Rip/clang_complete'
" Plugin 'terhechte/syntastic'
" Rip-Rip/clang_complete
" let g:clang_complete_auto = 1
" let g:clang_use_library = 1
" let g:clang_periodic_quickfix = 0
" let g:clang_close_preview = 1
" let g:clang_snippets = 1
" let g:clang_snippets_engine = 'ultisnips'
" let g:clang_exec =         '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'
" let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
" needed for syntastic (use terhechte/syntastic)
" let g:syntastic_cpp_config_file = '.clang_complete'

" BACKUP 2
" Tag based completion
" Plugin 'vim-scripts/OmniCppComplete'
" Plugin 'ervandew/supertab'
