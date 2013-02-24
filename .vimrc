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
colorscheme ruby

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

" Tabs
set tabstop=2      " Set the default tabstop
set softtabstop=2
set shiftwidth=2   " Set the default shift width for indents
set shiftround     " when at 3 spaces, and I hit > ... go to 4, not 5
set expandtab      " Make tabs into spaces (set by tabstop)
set smarttab       " Smarter tab levels

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
set number " Line numbers
set showmatch " Show matching brackets.
set matchtime=5 " Bracket blinking.
set novisualbell " No blinking
set noerrorbells " No noise.
set laststatus=2 " Always show status line
set statusline=[%04l-%04L,%04v]\ %F%m%r%h%w\ %p%% " Custom status line
set vb t_vb= " disable any beeps or flashes on error
set ruler " Show ruler
set showcmd " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI " Shortens messages
set mouse-=a " Disable mouse
set mousehide " Hide mouse after chars typed
set ww=b,s,<,>
set splitbelow
set splitright

" UTF8
set ffs=unix
set enc=utf-8

" Scrolling
set scrolloff=3
set scrolljump=3

" Memory
set history=1000
set undolevels=1000
set maxmem=2000000
set maxmemtot=2000000

" Supprime les espaces en fin de ligne avant de sauver
autocmd BufWrite * silent! %s/[\r \t]\+$//
autocmd BufWrite !Makefile :%s/	/    /g

" Toggle mouse on or off
map <C-m> :call ToggleActiveMouse()<CR>
function! ToggleActiveMouse()
  if &mouse == "a"
    exe "set mouse="
      echo "Mouse is off"
  else
    exe "set mouse=a"
    echo "Mouse is on"
  endif
endfunction

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
nnoremap <silent> <LocalLeader>rt :tabnew ~/.vim/vimrc<CR>
nnoremap <silent> <LocalLeader>re :e ~/.vim/vimrc<CR>
nnoremap <silent> <LocalLeader>rd :e ~/.vim/ <CR>

" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" Duplication
vnoremap <silent> <LocalLeader>= yP
nnoremap <silent> <LocalLeader>= YP

" Split line(opposite to S-J joining line)
nnoremap <silent> <C-J> gEa<CR><ESC>ew

" F9 Check syntax
autocmd FileType php map <F9> :w<CR>:!clear && php -l %<CR>
autocmd FileType ruby map <F9> :w<CR>:!clear && ruby -c %<CR>
autocmd FileType javascript map <F9> :w<CR>:!clear && jsl -process %<CR>

" S-T Neerd Tree
noremap <unique> <S-t> :NERDTreeToggle<CR>

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

" Invert line
" map <C-UP> ddkkp
" map <C-DOWN> ddp

" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR>

" Comment
map <C-c> \c j

" Macro
map <F2> @a

" FuzzyFinder
noremap <unique> <S-f> :FufFile<CR>
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|jpg|png|gif|DS_Store|sassc|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|.*[/\\]$'
let g:fuf_ignoreCase = 1
let g:fuf_abbrevMap = {
\   "^li" : [
\       "~/Github/littleWorld/src/",
\       "~/Github/littleWorld/src/**/",
\   ],
\   "^v" : [
\       "~/Github/veoday-site/app",
\       "~/Github/veoday-site/app/**/",
\       "~/Github/veoday-site/config",
\       "~/Github/veoday-site/config/**/",
\   ],
\ }

"Auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Tabular
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Autocommands
:augroup my_tab
if !exists("autocommands_loaded")
     let autocommands_loaded = 1
     au BufNewFile,BufRead Makefile set noexpandtab

     au BufNewFile,BufRead *.as set ft=actionscript
     au BufNewFile,BufRead *.as set expandtab
     au BufNewFile,BufRead *.as set softtabstop=4
     au BufNewFile,BufRead *.as set shiftwidth=4

     au BufNewFile,BufRead *.json set ft=json
     au BufNewFile,BufRead *.json set expandtab

     au BufNewFile,BufRead *.js set softtabstop=4
     au BufNewFile,BufRead *.js set shiftwidth=4

     au BufNewFile,BufRead *.tpl set softtabstop=4
     au BufNewFile,BufRead *.tpl set shiftwidth=4

     au BufNewFile,BufRead *.html.erb set ft=html
endif

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Editing
Bundle "http://github.com/rstacruz/sparkup.git", {'rtp': 'vim/'}

" Programming
Bundle "tpope/vim-rails"
Bundle "tpope/vim-bundler"

" Snippets
Bundle "http://github.com/gmarik/snipmate.vim.git"

" Syntax highlight
Bundle "Markdown"
Bundle "JSON.vim"
Bundle 'inside/actionscript.vim'

" (HT|X)ml tool
Bundle "ragtag.vim"

" Utilities
Bundle "repeat.vim"
Bundle "SuperTab"
Bundle 'godlygeek/tabular'
Bundle 'sessionman.vim'
Bundle 'Syntastic'
Bundle "http://github.com/gmarik/vim-visual-star-search.git"

" FuzzyFinder
Bundle "L9"
Bundle "FuzzyFinder"

" Zoomwin
Bundle "ZoomWin"
noremap <LocalLeader>o :ZoomWin<CR>
vnoremap <LocalLeader>o <C-C>:ZoomWin<CR>
inoremap <LocalLeader>o <C-O>:ZoomWin<CR>
noremap <C-W>+o :ZoomWin<CR>

" Ack
Bundle "ack.vim"
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

" tComment
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Command-T
Bundle "git://git.wincent.com/command-t.git"

filetype plugin indent on
