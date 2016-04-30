
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
    Plugin 'mbbill/undotree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/syntastic'
    Plugin 'valloric/YouCompleteMe'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    Plugin 'ryanss/vim-hackernews'
    Plugin 'mhinz/vim-startify'
    Plugin 'junegunn/goyo.vim'
    Plugin 'majutsushi/tagbar'
    Plugin 'ervandew/supertab'

    " Syntaxes
    Plugin 'tpope/vim-markdown'
    Plugin 'elzr/vim-json'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'jeroenbourgois/vim-actionscript'
    Plugin 'yaymukund/vim-rabl'
    Plugin 'AndrewRadev/vim-eco'
    Plugin 'groenewege/vim-less'
    Plugin 'tikhomirov/vim-glsl'
    Plugin 'dart-lang/dart-vim-plugin'
    " Plugin 'octol/vim-cpp-enhanced-highlight'

    " Searching
    Plugin 'scrooloose/nerdtree'
    Plugin 'rking/ag.vim'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'chazy/cscope_maps'

    " Formating
    Plugin 'tpope/vim-endwise'
    Plugin 'vim-scripts/tComment'
    Plugin 'godlygeek/tabular'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'editorconfig/editorconfig-vim'
    " Plugin 'ihacklog/HiCursorWords'
    " Plugin 'abudden/taghighlight-automirror' " run :UpdateTypesFile

    " UI
    Plugin 'gmarik/vim-visual-star-search'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'breuckelen/vim-resize'

    " Scheme
    Plugin 'jnurmine/Zenburn'
    Plugin 'jonathanfilip/vim-lucius'
    Plugin 'zeis/vim-kolor'
    Plugin 'itsthatguy/theme-itg-flat'
    Plugin 'jeetsukumaran/vim-nefertiti'
    Plugin 'NLKNguyen/papercolor-theme'
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
        au! BufEnter *.cpp,*.cc let b:fswitchdst = 'h,hpp'  | let b:fswitchlocs = './,../inc/,../../inc/,../inc/**/,../../inc/**/,../include/,../include/**/,../../include/,../../include/**/,../../../include/,../../../include/**/,../../../../include/,../../../../include/**/,../../../../../include/,../../../../../include/**/'
        au! BufEnter *.h,*.hpp  let b:fswitchdst = 'cpp,cc' | let b:fswitchlocs = './,../src/,../../src/,../src/**/,../../src/**/,../source/,../source/**/,../../source/,../../source/**/,../../../source/,../../../source/**/,../../../../source/,../../../../source/**/,../../../../../source/,../../../../../source/**/'

        " Auto save
        au CursorHold * nested silent wa

        " Make crontab happy
        au filetype crontab setlocal nobackup nowritebackup

		" Line number
		au InsertEnter * set norelativenumber
		au InsertLeave * set relativenumber

    augroup END

" }}}

" OPTIONS ---------------------------------- {{{

    " colors
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
    set guicolors
    set background=dark
    let g:gruvbox_italic=0
    colorscheme gruvbox
    hi VertSplit guifg=#504a45

    " rendering options
    set enc=utf-8
    set fileformats=unix,dos,mac
    set hidden
    set tags=./tags
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
	set relativenumber
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
    set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc,*.pump

    " vim command line
    set cmdheight=1
    set report=0
    set shortmess=IAW
    set noshowmode
    set noruler
    set mousehide

    " window scroll
    set scrolloff=5
    set scrolljump=5

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

    " FZF
    set rtp+=/usr/local/opt/fzf

    " cscope
    set cst
    set csto=1
    set cspc=2
    set nocsverb
    if filereadable(".git/cscope.out")
        cs add .git/cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " statusline
    set statusline=%f\ %r%m%=%l/%L\ -\ %P

" }}}

" MAPPINGS --------------------------------- {{{

    " F1-Help F2-Macro F3-UndoTree F5-NERDTree F6-Reload F12-Paste
    map <F1> "zyiw:exe "h ".@z.""<CR>
    map <F2> @a
    map <F5> :NERDTreeToggle<CR>
    map <F6> :Goyo<CR>
    map <F12> :r! pbpaste<CR><Esc>

    " FZF
    nnoremap <C-f> :FZF<CR>

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
    ab   st   static
    ab   cl   console.log

	" Don't move around in insert mode
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>

    " save time
    nnoremap ; :
    nnoremap q: :q

    " select the current line without indentation
    nnoremap vv ^vg_

    " don't lose selection after indenting
    vnoremap < <gv
    vnoremap > >gv

    " clear searches
    nnoremap <silent> <SPACE> :nohlsearch<CR>

    " check syntaxt
    nnoremap <silent> <SPACE><SPACE> :YcmForceCompileAndDiagnostics<CR><CR>:GitGutterAll<CR>

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

    " Cscope
    nmap <C-]> :cs find s <C-R>=expand("<cword>")<CR><CR>

    " Only higlight on #
    nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

	" Resize windows
	nmap <unique> <UP> 4<C-w>+
	nmap <unique> <DOWN> 4<C-w>-
	nmap <unique> <LEFT> 4<C-w><
	nmap <unique> <RIGHT> 4<C-w>>

" }}}

" PLUGINS ---------------------------------- {{{

    " UndoTree
    " -------------------------------------------------------------------------
    nnoremap <silent> <F3> :silent UndotreeToggle<CR>
    inoremap <silent> <F3> <ESC>:silent UndotreeToggle<CR>

    " Syntastic
    " -------------------------------------------------------------------------
    let g:syntastic_actionscript_mxmlc_exe = 'fcshctl mxmlc -source-path=src '
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_enable_signs = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 1
    let g:syntastic_javascript_checkers = ['jshint']
    " let g:syntastic_ruby_checkers = ['rubylint']
    let g:syntastic_cpp_checkers = ['cppcheck']
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['cpp, ''javascript', 'actionscript'],
        \ 'passive_filetypes': ['c', 'java', 'xhtml', 'sh']
    \ }

    " Ultisnips
    " -------------------------------------------------------------------------
    let g:UltiSnipsExpandTrigger = "<Tab>"
    let g:UltiSnipsListSnippets = "<C-Tab>"
    let g:UltiSnipsJumpForwardTrigger = "<C-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
    inoremap <c-x><c-k> <c-x><c-k>

    " YouCompleteMe
    " -------------------------------------------------------------------------
    let g:ycm_collect_identifiers_from_tags_files = 0
    let g:ycm_always_populate_location_list = 1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_filetype_blacklist = {'vim' : 1, 'ruby': 1}
    let g:ycm_key_list_select_completion=['<Down>']
    let g:ycm_key_list_previous_completion=['<Up>']

    " T-Comment
    " -------------------------------------------------------------------------
    nnoremap <C-c> :TComment<CR>j
    vnoremap <C-c> :TComment<CR>j

    " Tabularize
    " -------------------------------------------------------------------------
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>

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
    let g:gitgutter_override_sign_column_highlight = 0
    let g:gitgutter_enabled = 1
    let g:gitgutter_realtime =1
    let g:gitgutter_sign_added = '▎'
    let g:gitgutter_sign_modified = '▎'
    let g:gitgutter_sign_removed= '▎'
    let g:gitgutter_sign_modified_removed= '▎'
    set updatetime=400

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
    " Switch to the file and load it in place
    nmap <silent> <Leader>s  :FSHere<cr>

    " EasyMotion
    " -------------------------------------------------------------------------
	" Bidirection jump
	map  / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)
	" Bidirection jump base on 2 chars
	nmap s <Plug>(easymotion-s2)
	" Jump to line
	map <Leader>j <Plug>(easymotion-j)
	map <Leader>k <Plug>(easymotion-k)
	" Smart case
	let g:EasyMotion_smartcase = 1

    " Goyo
    " -------------------------------------------------------------------------
    let g:goyo_width = 120
    function! s:goyo_enter()
        set noshowmode
        set noshowcmd
        hi VertSplit guibg=#282828
        hi CursorLine guibg=#282828
        hi StatusLine guibg=#282828
        hi StatusLineNC guibg=#282828

    endfunction
    function! s:goyo_leave()
        set showmode
        set showcmd
    endfunction
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
