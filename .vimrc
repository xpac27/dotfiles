
" .vimrc

" BASICS & BUNDLES ------------------------- {{{

    set nocompatible
    filetype off
    filetype plugin indent off

    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()

    Plugin 'L9'

    " Big features
    Plugin 'gmarik/Vundle.vim'
    Plugin 'sjl/gundo.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/syntastic'
    Plugin 'valloric/YouCompleteMe'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    Plugin 'ryanss/vim-hackernews'
    Plugin 'mhinz/vim-startify'

    " Syntaxes
    Plugin 'tpope/vim-markdown'
    Plugin 'elzr/vim-json'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'jeroenbourgois/vim-actionscript'
    Plugin 'yaymukund/vim-rabl'
    Plugin 'AndrewRadev/vim-eco'
    Plugin 'groenewege/vim-less'

    " Searching
    Plugin 'kien/ctrlp.vim'
    Plugin 'ivan-cukic/vim-ctrlp-switcher'
    Plugin 'scrooloose/nerdtree'
    Plugin 'mileszs/ack.vim'
    Plugin 'derekwyatt/vim-fswitch'

    " Formating
    Plugin 'tpope/vim-endwise'
    Plugin 'vim-scripts/tComment'
    Plugin 'godlygeek/tabular'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'rhysd/vim-clang-format'

    " UI
    Plugin 'bling/vim-airline'
    Plugin 'gmarik/vim-visual-star-search'
    Plugin 'mhinz/vim-signify'
    Plugin 'airblade/vim-gitgutter'

    " Scheme
    Plugin 'jnurmine/Zenburn'
    Plugin 'jonathanfilip/vim-lucius'
    Plugin 'zeis/vim-kolor'
    Plugin 'itsthatguy/theme-itg-flat'
    Plugin 'jeetsukumaran/vim-nefertiti'
    Plugin 'morhetz/gruvbox'

    call vundle#end()
    filetype plugin indent on
    syntax on

" }}}

" AUTOCOMMANDS ----------------------------- {{{

    augroup vim_stuff
        au!

        " source local vimrc
        " au BufNewFile,BufRead * call SetLocalOptions(bufname("%"))
        au VimEnter * call SetLocalOptions(bufname("%"))

        " enable spell checking
        " au BufEnter *.cpp  set spell
        " au BufEnter *.h  set spell

        " restore position in file
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

        " force actionscript on as files
        au BufNewFile,BufRead *.as set ft=actionscript

        " set zimbu filetype
        au! BufNewFile,BufRead *.zu setf zimbu

        " activate FileSwitch on cpp and h files
        au! BufEnter *.cpp,*.cc let b:fswitchdst = 'hpp,h'  | let b:fswitchlocs = './,../inc/,../inc/**/,../include/,../include/**/,../../include/,../../include/**/'
        au! BufEnter *.h,*.hpp  let b:fswitchdst = 'cpp,cc' | let b:fswitchlocs = './,../src/,../../src/,../source/,../source/**/,../../source/,../../source/**/'

    augroup END

" }}}

" OPTIONS ---------------------------------- {{{

    " colors
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
    set guicolors
    " colorscheme lucius
    " LuciusDark
    colorscheme nefertiti
    " colorscheme itg_flat
    " colorscheme kolor
    " colorscheme zenburn
    " colorscheme gruvbox

    " rendering options
    set enc=utf-8
    set fileformats=unix,dos,mac
    set hidden
    set tags=./tags;/
    set backspace=indent,eol,start
    set ttyfast
    set lazyredraw

    " disable any beeps or flashes on error
    set noerrorbells
    set novisualbell
    set vb t_vb=

    " detect file changes
    set autoread

    " spell
    set spelllang=en_us
    set nospell

    " percistancy
    set sessionoptions+=tabpages,globals
    set viminfo=!,'100,h,n~/.viminfo
    set history=1000
    set undolevels=1000
    set undofile
    set undodir=~/.vim/undofiles
    set undoreload=1000

    " safety
    set backup
    set writebackup
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//

    " presentation
    set number
    set cursorline
    set nolist
    set laststatus=2

    " wrap
    set nowrap
    set textwidth=0

    " terminal
    set title
    set titlestring=(\ %(%{&ft},\ %)%{&ff}%(,\ %{&fenc}%)\ )
    set titlelen=100

    " mouse
    set mouse-=a

    " tabs
    set tabpagemax=999
    set showtabline=1

    " completion
    " set complete+=kspell
    set complete-=i
    set completeopt=longest,menuone
    set omnifunc=syntaxcomplete#Complete

    " menu
    set wildmenu
    set wildmode=longest,list
    set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,tags,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc

    " vim command line
    set cmdheight=1
    set report=0
    set shortmess=IAW
    set noshowmode
    set noruler
    set mousehide

    " window scroll
    set scrolloff=3
    set scrolljump=3

    " tabs
    set smarttab
    set expandtab
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4
    set shiftround
    set smartindent
    " set autoindent
    " set cindent
    " set cinoptions=:s,ps,ts,cs
    " set cinwords=if,else,elsif,when,while,do,for,switch,case

    " splits
    set splitbelow
    set splitright
    set noequalalways

    " search
    set ignorecase
    set smartcase
    set showmatch
    set incsearch
    set hlsearch
    set gdefault

    " conveniences
    set timeoutlen=300
    set maxmem=2000000
    set maxmemtot=2000000

    " ignore files (command-t)
    set wildignore+=*.o,*.obj,*.pump

    " popup menu
    set pumheight=15

    " override popup menu colors
    " hi Pmenu		cterm=none	ctermfg=255	ctermbg=238
    " hi PmenuSel		cterm=none	ctermfg=16	ctermbg=227
    " hi PmenuSbar	cterm=none	ctermfg=240	ctermbg=240
    " hi PmenuThumb	cterm=none	ctermfg=255	ctermbg=255

    " override fold bar colors
    " hi Folded       cterm=none  ctermfg=244 ctermbg=233

    " override cursorline colors
    hi CursorLine guibg=#2f2e30 cterm=none
" }}}

" MAPPINGS --------------------------------- {{{

    " F1-Help F2-Macro F3-Gundo F5-NERDTree F6-FuzzyFinder F12-Paste
    map <F1> "zyiw:exe "h ".@z.""<CR>
    map <F2> @a
    map <F12> :r! pbpaste<CR><Esc>

    " typos
    ia   feild    field
    ia   flase    false
    ia   lenght   length
    ia   toogle   toggle
    ia   wiht     with
    ia   heigth   height
    ia   retrun   return

    " shortcuts
    ab   fu   function
    ab   pr   private
    ab   pt   protected
    ab   pu   public
    ab   st   static
    ab   cl   console.log

    " save time
    nnoremap ; :
    nnoremap q: :q

    " tabs
    nnoremap <silent> <leader>T :tabedit! <C-R>=expand("#:p")<CR><CR>
    nnoremap <silent> <leader>Y :tabclose<CR>

    " windows
    nnoremap <silent> Q :call CloseWindow()<CR>
    nnoremap <Tab> <C-w>
    nnoremap <leader>w <C-W>v:b#<CR>
    nnoremap <leader>W <C-W>s:b#<CR>
    nnoremap <unique> <C-UP> 4<C-w>+
    nnoremap <unique> <C-DOWN> 4<C-w>-
    nnoremap <unique> <C-LEFT> 4<C-w><
    nnoremap <unique> <C-RIGHT> 4<C-w>>

    " select the current line without indentation
    nnoremap vv ^vg_

    " don't lose selection after indenting
    vnoremap < <gv
    vnoremap > >gv

    " Only higlight on #
    nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

    " keep search matches in the middle of the window
    nnoremap n nzvzz
    nnoremap N Nzvzz

    " clear searches
    nnoremap <silent> <leader><SPACE> :noh<CR>

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

    " duplication
    nnoremap <silent> <LocalLeader>= YP

    " copy/past word
    noremap <unique> <Leader>y viw"py
    noremap <unique> <Leader>p viw"pp

    " Make
    nnoremap <unique> <Leader>m :!make<CR>

    " YCM GoTo
    nnoremap <leader>d :YcmCompleter GoTo<CR>

    " Switch to the file and load it into the window on the right >
    nmap <silent> <Leader>sr :FSRight<cr>
    " Switch to the file and load it into a new window split on the right >
    nmap <silent> <Leader>sR :FSSplitRight<cr>
    " Switch to the file and load it into the window on the left >
    nmap <silent> <Leader>sl :FSLeft<cr>
    " Switch to the file and load it into a new window split on the left >
    nmap <silent> <Leader>sH :FSSplitLeft<cr>

" }}}

" PLUGINS ---------------------------------- {{{

    " Gundo
    " -------------------------------------------------------------------------
    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " Syntastic
    " -------------------------------------------------------------------------
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

    " Ultisnips
    " -------------------------------------------------------------------------
    let g:UltiSnipsExpandTrigger="<Tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " YouCompleteMe
    " -------------------------------------------------------------------------
    " let g:ycm_collect_identifiers_from_tags_files = 0
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_filetype_blacklist = {'vim' : 1}
    let g:ycm_key_list_select_completion=['<Down>']
    let g:ycm_key_list_previous_completion=['<Up>']

    " CtrlP
    " -------------------------------------------------------------------------
    let g:ctrlpswitcher_mode = 1
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
        \ 'fallback': 'find %s -type f'
        \ }

    " Airline
    " -------------------------------------------------------------------------
    let g:airline_theme = 'ubaryd'
    let g:airline#extensions#branch#enabled = 0

    " T-Comment
    " -------------------------------------------------------------------------
    nnoremap // :TComment<CR>j
    vnoremap // :TComment<CR>j

    " Tabularize
    " -------------------------------------------------------------------------
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>

    " Fugitive
    " -------------------------------------------------------------------------
    nnoremap <leader>gd :Gdiff<cr>
    nnoremap <leader>gD :diffoff!<cr><C-W>h:bd<cr>

    " NERD Tree
    " -------------------------------------------------------------------------
    noremap <F5> :NERDTreeToggle<CR>

    " PyClewn
    " -------------------------------------------------------------------------
    let g:pyclewn_args = '--gdb=async'

    " Clang-Format
    " -------------------------------------------------------------------------
    let g:clang_format#auto_format_on_insert_leave = 0
    let g:clang_format#style_options = {
        \ "Standard" : "C++11",
        \ "ColumnLimit" : 0,
        \ "AccessModifierOffset" : -4,
        \ "MaxEmptyLinesToKeep" : 1,
        \ "AllowShortCaseLabelsOnASingleLine" : "true",
        \ "BreakBeforeBraces" : "Linux"
    \ }

    " Signify
    " -------------------------------------------------------------------------
    let g:signify_vcs_list = [ 'git', 'hg' ]
    let g:signify_disable_by_default = 1

    " Git-Gutter
    " -------------------------------------------------------------------------
    let g:gitgutter_enabled = 1
    set updatetime=250
    " highlight GitGutterAdd ctermbg=65
    " highlight GitGutterChange ctermbg=101
    " highlight GitGutterDelete ctermbg=95

    " Startify
    " -------------------------------------------------------------------------
    let g:startify_files_number = 12
    let g:startify_session_persistence = 1
    let g:startify_session_delete_buffers = 1
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
" }}}

" FUNCTIONS -------------------------------- {{{

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

" }}}

" BACKUPS -------------------------------- {{{

    " 1
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

    " 2
    " Tag based completion
    " Plugin 'vim-scripts/OmniCppComplete'
    " Plugin 'ervandew/supertab'

