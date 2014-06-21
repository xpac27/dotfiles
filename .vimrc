" General
set nocompatible        " This must be first, because it changes other options as side effect
set ttyfast             " improve drawing
set lazyredraw          " do not redraw while running macros
set autoread            " detect file changes
set title               " change the terminal's title
set noequalalways       " do not auto resize closed and oppened splits
set nobackup            " no backups
set pastetoggle=<F10>   " toggle between paste and normal: for 'safer' pasting from keyboard
set timeoutlen=250      " Time to wait after ESC (default causes an annoying delay)
set tabpagemax=999      " let me tab as much as I want

" Theme
set t_Co=256
set background=dark
colorscheme smyck

" Backup
set backup
set writebackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Buffer
set hidden  " The current buffer can be put to the background without writing to disk

" Search
set hlsearch   " highlight search
set ignorecase " Do case in sensitive matching with
set smartcase  " be sensitive when there's a capital letter
set incsearch  " start searching imediatly

" Formatting
set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)

" Wrapping
set nowrap
set textwidth=0 " Don't wrap lines by default

" Wild
set wildmenu
set wildmode=longest,list       " At command line, complete longest common string, then list alternatives.
set backspace=indent,eol,start  " more powerful backspacing

" Indent
set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,elsif,when,while,do,for,switch,case

" Syntax
syntax on " enable syntax

" Files
filetype plugin indent on " Automatically detect file types.

" Visual
set number        " Line numbers
set showmatch     " Show matching brackets.
set matchtime=5   " Bracket blinking.
set novisualbell  " No blinking
set noerrorbells  " No noise.
set laststatus=2  " Always show status line
set vb t_vb=      " disable any beeps or flashes on error
set ruler         " Show ruler
set showcmd       " Display an incomplete command in the lower right corner of the Vim window
set mouse-=a      " Disable mouse
set mousehide     " Hide mouse after chars typed
set ww=b,s,<,>
set splitbelow
set splitright

" Status line
set statusline=[%04l-%04L,%04v]\ %F%m%r%h%w\ %p%% " Custom status line

" UTF8
set ffs=unix,dos
set enc=utf-8

" Scrolling
set scrolloff=3
set scrolljump=3

" Memory
set history=1000
set undolevels=1000
set maxmem=2000000
set maxmemtot=2000000

" Toggle mouse on or off
" map <C-m> :call ToggleActiveMouse()<CR>
" function! ToggleActiveMouse()
"   if &mouse == "a"
"     exe "set mouse="
"       echo "Mouse is off"
"   else
"     exe "set mouse=a"
"     echo "Mouse is on"
"   endif
" endfunction

" Automatic word correction
ia feild field
ia flase false
ia lenght length
ia toogle toggle

" Shortcuts
ab fu function
ab pr private
ab pt protected
ab pu public
ab st static
ab cl console.log(

" save time
nnoremap ; :

" turn of search hightlight
nmap <silent> \/ :nohlsearch<CR>

" Quickly edit/reload the vimrc file
nnoremap <silent> <LocalLeader>rs :source ~/.vimrc<CR>
nnoremap <silent> <LocalLeader>rt :tabnew ~/.vimrc<CR>
nnoremap <silent> <LocalLeader>re :e ~/.vimrc<CR>
nnoremap <silent> <LocalLeader>rd :e ~/.vim/ <CR>

" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" Duplication
vnoremap <silent> <LocalLeader>= yP
nnoremap <silent> <LocalLeader>= YP

" Split line(opposite to S-J joining line)
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

" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR>

" Comment
map <C-c> \c j

" Macro
map <F2> @a

" CommandT
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=10

" NeerdTree
noremap <unique> <Leader>r :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_auto_loc_list=0
let g:syntastic_mode_map={ 'mode': 'active',
\   'active_filetypes': [],
\   'passive_filetypes': ['html', 'xhtml'] }

" FuzzyFinder
noremap <unique> <Leader>f :FufFile<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|jpg|png|gif|DS_Store|sassc|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|.*[/\\]$'
let g:fuf_ignoreCase = 1
let g:fuf_abbrevMap = {
\   "^kp" : [
\       "~/King/kingdom-views-as3/package/src",
\       "~/King/kingdom-views-as3/package/src/**/",
\   ],
\   "^ks" : [
\       "~/King/kingdom-views-as3/sample/src",
\       "~/King/kingdom-views-as3/sample/src/**/",
\   ],
\   "^kr" : [
\       "~/King/kingdom-views-as3/resources",
\       "~/King/kingdom-views-as3/resources/**/",
\   ],
\   "^s" : [
\       "~/King/spaceland/src/com/king/flash/spaceland",
\       "~/King/spaceland/src/com/king/flash/spaceland/**/",
\   ],
\   "^f" : [
\       "~/King/flatland/src/com/king/flash/flatland",
\       "~/King/flatland/src/com/king/flash/flatland/**/",
\   ],
\   "^p" : [
\       "~/King/plataforma/trunk/flash/src/com/king/platform",
\       "~/King/plataforma/trunk/flash/src/com/king/platform/**/",
\   ],
\ }

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" ==========================
" Autocommands filetypes
" ==========================

function! SetupEnvironment()

  if expand('%:p') =~ $HOME. "/King"

    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal shiftround
    setlocal noexpandtab
    " setlocal binary noeol
    setlocal autoindent

  else

    setlocal expandtab
    setlocal smarttab
    setlocal shiftround
    setlocal autoindent

    if &filetype == 'ruby'
      setlocal softtabstop=2
      setlocal shiftwidth=2

    elseif &filetype == 'erb'
      setlocal softtabstop=2
      setlocal shiftwidth=2
      setlocal filetype=html

    else
      setlocal softtabstop=4
      setlocal shiftwidth=4
    endif

    au BufWrite <buffer> silent! %s/[\r \t]\+$//  " Remove useless tabs at the end of lines

  endif

  if &filetype == 'make'
    setlocal noexpandtab
  endif

endfunction
au BufNewFile,BufRead *.as set ft=actionscript
au BufNewFile,BufRead *.json set ft=json
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=markdown
au BufRead,BufNewFile Gemfile,Rakefile,Capfile,*.rake,config.ru set ft=ruby
au BufRead,BufNewFile * call SetupEnvironment()

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'L9'
Plugin 'Markdown'
Plugin 'JSON.vim'
Plugin 'ragtag.vim'
Plugin 'sessionman.vim'
Plugin 'Syntastic'
Plugin 'FuzzyFinder'
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'inside/actionscript.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'thoughtbot/vim-rspec'
Plugin 'yaymukund/vim-rabl'
Plugin 'gmarik/vim-visual-star-search'
Plugin 'wincent/Command-T'
Plugin 'bling/vim-airline'
let g:airline_theme = 'badwolf'
Plugin 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>
Plugin 'tComment'
nnoremap // :TComment<CR>j
vnoremap // :TComment<CR>j
Plugin 'Shougo/vimproc.vim'
map <Leader>d :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = '!zeus rspec {spec}'
Plugin 'http://github.com/rstacruz/sparkup.git', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
