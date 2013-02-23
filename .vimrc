set nocompatible        " This must be first, because it changes other options as side effect
set hlsearch            " Surligne les resultats de recherche
set nowrap              " Pas de retour a la ligne auto (affichage)
set showmatch           " Affiche parenthese correspondante
set number              " affiche les numero de ligne
set ignorecase          " ignore la case en mode recherch
set ruler               " show line cursor infos
set ttyfast             " improve drawing
set lazyredraw          " do not redraw while running macros
set autoread            " detect file changes
set hidden              " Better buffer configuration
set autoindent          " Indentation automatique
set smartindent         " Ameliore l'indentation auto
set title               " change the terminal's title
set noequalalways       " do not auto resize closed and oppened splits

" backup
set backup
set writebackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" display whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>. " allow tabs in some files

" allow filetype detection
filetype plugin indent on

" let me delete anything in insert mode
set backspace=indent,eol,start

" custom status line
set statusline=[%04l-%04L,%04v]\ %F%m%r%h%w\ %p%%
set laststatus=2

" visual
syntax enable

" user utf8
set ffs=unix
set enc=utf-8

" let me tab as much as I want
set tabpagemax=999

" Scrolling
set scrolloff=3
set scrolljump=3

" tabs
set softtabstop=4       " Largeur d'une tabulation
set shiftwidth=4        " Largeur de l'indentation
set expandtab           " Utilise des espaces plutot que les tabulation
set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 5

" Memory
set history=1000
set undolevels=1000
set maxmem=2000000
set maxmemtot=2000000

" Temp files
set nobackup
set noswapfile

" Enamble mouse
set mouse=a
set ww=b,s,<,>

" Visual options
set wildmenu
set wildmode=list:longest,full

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
ia fu function
ia pr private
ia pt protected
ia pu public
ia st static

" change the mapleader from \ to ,
"let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" F9 Check syntax
autocmd FileType php map <F9> :w<CR>:!clear && php -l %<CR>
autocmd FileType ruby map <F9> :w<CR>:!clear && ruby -c %<CR>
autocmd FileType javascript map <F9> :w<CR>!clear && :jsl -process %<CR>

" F2 Past toggle
set pastetoggle=<F2>

" S-F FuzzyFinder
noremap <unique> <S-f> :FufFile<CR>

" S-T Neerd Tree
noremap <unique> <S-t> :NERDTreeToggle<CR>

" save time
nnoremap ; :

" turn of search hightlight
nmap <silent> // :nohlsearch<CR>

" Session
let sessionman_save_on_exit = 1
noremap <unique> <Leader>ss :SessionSave<CR>
noremap <unique> <Leader>sl :SessionList<CR>
noremap <unique> <Leader>so :SessionOpen

" copy past word
noremap <unique> <Leader>y viw"py
noremap <unique> <Leader>p viw"pp

" Make
nnoremap <unique> <Leader>m :!make<CR>

" Resize window
nnoremap <unique> <Leader>= 6<C-w>+
nnoremap <unique> <Leader>- 6<C-w>->
nnoremap <unique> <Leader>[ 8<C-w><
nnoremap <unique> <Leader>] 8<C-w>>

" Invert line
"map <C-UP> ddkkp
"map <C-DOWN> ddp

" Switch window
map <Tab>o :wa<CR>
map <Tab> <C-w>

" Comment
map <C-c> \c j

" Macro
map <F2> @a

" FuzzyFinder
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

     au BufNewFile,BufRead *.rb set softtabstop=2
     au BufNewFile,BufRead *.rb set shiftwidth=2

     au BufNewFile,BufRead *.html.erb set ft=html
     au BufNewFile,BufRead *.html.erb set softtabstop=2
     au BufNewFile,BufRead *.html.erb set shiftwidth=2
endif

" pathogen
call pathogen#infect()

" THEME
set t_Co=256
set background=dark
"colorscheme Tomorrow-Night
colorscheme ruby
