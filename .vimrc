
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
    Plugin 'ludovicchabant/vim-lawrencium'
    Plugin 'scrooloose/syntastic'
    Plugin 'valloric/YouCompleteMe'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    Plugin 'ryanss/vim-hackernews'
    Plugin 'mhinz/vim-startify'

    " Debug
    Plugin 'xpac27/vim-lldb'
    Plugin 'vim-scripts/Conque-GDB'

    " Syntaxes
    Plugin 'tpope/vim-markdown'
    Plugin 'elzr/vim-json'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'jeroenbourgois/vim-actionscript'
    Plugin 'yaymukund/vim-rabl'
    Plugin 'AndrewRadev/vim-eco'
    Plugin 'groenewege/vim-less'
    Plugin 'tikhomirov/vim-glsl'

    " Searching
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'mileszs/ack.vim'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'easymotion/vim-easymotion'

    " Formating
    Plugin 'tpope/vim-endwise'
    Plugin 'vim-scripts/tComment'
    Plugin 'godlygeek/tabular'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'tpope/vim-surround'

    " UI
    Plugin 'bling/vim-airline'
    Plugin 'asenac/vim-airline-loclist'
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

        " use tabs in Makefile
        au BufNewFile,BufRead Makefile set noexpandtab

        " source local vimrc
        au VimEnter * call SetLocalOptions(bufname("%"))

        " enable spell checking
        " au BufEnter *.cpp  set spell
        " au BufEnter *.h  set spell

        " restore position in file
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

        " force actionscript on .as files
        au BufNewFile,BufRead *.as set ft=actionscript

        " set zimbu filetype
        au! BufNewFile,BufRead *.zu setf zimbu

        " activate FileSwitch on cpp and h files
        au! BufEnter *.cpp,*.cc let b:fswitchdst = 'h,hpp'  | let b:fswitchlocs = './,../inc/,../inc/**/,../include/,../include/**/,../../include/,../../include/**/,../../../include/,../../../include/**/,../../../../include/,../../../../include/**/,../../../../../include/,../../../../../include/**/'
        au! BufEnter *.h,*.hpp  let b:fswitchdst = 'cpp,cc' | let b:fswitchlocs = './,../src/,../../src/,../source/,../source/**/,../../source/,../../source/**/,../../../source/,../../../source/**/,../../../../source/,../../../../source/**/,../../../../../source/,../../../../../source/**/'

        " Higlight word under cursor
        au CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        au BufLeave * call clearmatches()

        " Auto save
        au CursorHold * silent wa

		" Force syntax check when entering the buffer
		au BufEnter *.cpp,*.hpp,*.h silent YcmForceCompileAndDiagnostics

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
    set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,tags,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc,*.pump

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

	" to list colors run :so $VIMRUNTIME/syntax/hitest.vim
    " error colors
    hi SpellBad cterm=underline guibg=#990000 guifg=#ffcccc
    hi YcmErrorSign cterm=none guibg=#990000 guifg=#ffcccc
    hi SpellCap cterm=underline guibg=#999900 guifg=#ffffcc
    hi YcmWarningSign cterm=none guibg=#999900 guifg=#ffffcc

    " split color
    hi vertsplit guifg=#1f1c1c guibg=#1f1c1c
    hi LineNr guibg=#1f1c1c
    hi SignColumn guibg=#1f1c1c

    " search
    hi Search cterm=underline guibg=#2c2824 guifg=#fffdc0
    hi IncSearch cterm=underline guibg=#403a34 guifg=#fffdc0

" }}}

" MAPPINGS --------------------------------- {{{

    " F1-Help F2-Macro F3-Gundo F5-NERDTree F6-Reload F12-Paste
    map <F1> "zyiw:exe "h ".@z.""<CR>
    map <F2> @a
    map <F5> :NERDTreeToggle<CR>
    map <F6> :checktime<CR>
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
    nmap <leader> <C-w>
    nmap <leader>w <C-W>v:b#<CR>
    nmap <leader>W <C-W>s:b#<CR>
    nmap <unique> <C-UP> 4<C-w>+
    nmap <unique> <C-DOWN> 4<C-w>-
    nmap <unique> <C-LEFT> 4<C-w><
    nmap <unique> <C-RIGHT> 4<C-w>>

    " select the current line without indentation
    nnoremap vv ^vg_

    " don't lose selection after indenting
    vnoremap < <gv
    vnoremap > >gv

    " clear searches
    nnoremap <silent> <SPACE> :nohlsearch<CR>

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

" }}}

" PLUGINS ---------------------------------- {{{

    " Gundo
    " -------------------------------------------------------------------------
    nnoremap <silent> <F3> :silent GundoToggle<CR>
    inoremap <silent> <F3> <ESC>:silent GundoToggle<CR>a

    " Syntastic
    " -------------------------------------------------------------------------
    let g:syntastic_actionscript_mxmlc_exe = 'fcshctl mxmlc -source-path=src '
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list=1
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
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_always_populate_location_list = 1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_filetype_blacklist = {'vim' : 1, 'ruby': 1}
    let g:ycm_key_list_select_completion=['<Down>']
    let g:ycm_key_list_previous_completion=['<Up>']

    " CtrlP
    " -------------------------------------------------------------------------
   let g:ctrlp_user_command = {
       \ 'types': {
           \ 1: ['.git', 'cd %s && git ls-files'],
           \ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
		\ 'fallback': 'find %s -type f'
	\ }

    " Airline
    " -------------------------------------------------------------------------
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#branch#enabled = 0
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#left_alt_sep = '|'

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
    let g:signify_vcs_list = [ 'hg' ]
    let g:signify_disable_by_default = 1
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '-'
    let g:signify_sign_delete_first_line = '-'
    let g:signify_sign_change            = '~'
    let g:signify_sign_changedelete      = '~'
    highlight SignifySignAdd          cterm=none guibg=#363636  guifg=#99ff99
    highlight SignifySignDelete       cterm=none guibg=#363636  guifg=#ff9999
    highlight SignifyLineChangeDelete cterm=none guibg=#363636  guifg=#ff9999
    highlight SignifySignChange       cterm=none guibg=#363636  guifg=#ffff99

    " Git-Gutter
    " -------------------------------------------------------------------------
    let g:gitgutter_enabled = 1
    let g:gitgutter_realtime =1
    set updatetime=1250

    " Conque GDB / Term
    " -------------------------------------------------------------------------
    let g:ConqueTerm_ReadUnfocused = 1
    let g:ConqueTerm_Color = 1
    let g:ConqueTerm_StartMessages = 0
	let g:ConqueTerm_UnfocusedUpdateTime = 250
    let g:ConqueTerm_FocusedUpdateTime = 80
    let g:ConqueTerm_TERM = 'xterm'
    let g:ConqueGdb_SrcSplit = 'left'
    let g:ConqueGdb_SaveHistory = 1
    " nnoremap <silent> <Leader>Y :ConqueGdbCommand y<CR>
    " nnoremap <silent> <Leader>N :ConqueGdbCommand n<CR>

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
    " Switch to the file and load it into the window on the right >
    nmap <silent> <Leader>sr :FSRight<cr>
    " Switch to the file and load it into a new window split on the right >
    nmap <silent> <Leader>sR :FSSplitRight<cr>
    " Switch to the file and load it into the window on the left >
    nmap <silent> <Leader>sl :FSLeft<cr>
    " Switch to the file and load it into a new window split on the left >
    nmap <silent> <Leader>sL :FSSplitLeft<cr>
    " Switch to the file and load it in place
    nmap <silent> <Leader>ss :FSHere<cr>

    " EasyMotion
    " -------------------------------------------------------------------------
	" Bidirection jump
	map  / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)
	" Bidirection jump base on 2 chars
	nmap s <Plug>(easymotion-s2)
	" Next-Prev
	map  <C-n> <Plug>(easymotion-next)
	map  <C-N> <Plug>(easymotion-prev)
	" Jump to line
	map <Leader>j <Plug>(easymotion-j)
	map <Leader>k <Plug>(easymotion-k)
	" Smart case
	let g:EasyMotion_smartcase = 1

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

