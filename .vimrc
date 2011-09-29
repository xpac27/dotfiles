set hlsearch            " Surligne les resultats de recherche
set nowrap              " Pas de retour a la ligne auto (affichage)
set showmatch           " Affiche parenthese correspondante
set number              " affiche les numero de ligne
set ignorecase          " ignore la case en mode recherch
set ruler               " show line cursor infos
set ttyfast             " improve drawing
set lazyredraw
set autoread            " detect file changes
set list                " show invisible char
set t_Co=256            " Specifies that the terminal can support 256 colors
set hidden              " Better buffer configuration
set autoindent          " Indentation automatique
set smartindent         " Ameliore l'indentation auto

" let me delete anything in insert mode
set backspace=indent,eol,start

" custom status line
set statusline=[%04l-%04L,%04v]\ %F%m%r%h%w\ %p%%
set laststatus=2

syntax enable
colorscheme ruby
"set background=dark
" let g:solarized_termcolors=256 " uncomment if you use a custom terminal color theme
"colorscheme solarized

" user utf8
set ffs=unix             " set folding format to prevent from bad carriage return
set enc=utf-8

" let me tab as much as I want
set tabpagemax=99

" Scrolling
set scrolloff=3
set scrolljump=3

" Enable folds
"set foldenable
"set foldmethod=indent

" tabs
set softtabstop=4       " Largeur d'une tabulation
set shiftwidth=4        " Largeur de l'indentation
set expandtab           " Utilise des espaces plut√¥t que le caract√®re tabulation
set shiftround          " when at 3 spaces, and I hit > ... go to 4, not 5

" Memory
set history=1000
set undolevels=1000
set maxmem=2000000
set maxmemtot=2000000

" Temp files
set backup
set writebackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set mouse=a
set ww=b,s,<,>

" Visual options
set wildmenu
set wildmode=list:longest,full

" Supprime les espaces en fin de ligne avant de sauver
autocmd BufWrite * silent! %s/[\r \t]\+$//
autocmd BufWrite !Makefile :%s/	/    /g

" Alt right or left in insert mode tu move to word
imap <alt-left> <c-o>b
imap <alt-right> <c-o>w

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
ab feild field
ab flase false
ab lenght length
ab toogle toggle

" Shortcuts
ab fu function
ab pr private
ab pu public
ab st static

" Check js syntax
noremap <unique> <Leader>js :!clear && jsl -process %<CR>

" Check php syntax
noremap <unique> <Leader>php :!clear && php -l %<CR>

" FuzzyFinder
noremap <unique> <S-f> :FuzzyFinderFile<CR>

" Neerd Taglist
"noremap <unique> <Leader>c :TlistToggle<CR>

" Neerd Tree
noremap <unique> <S-t> :NERDTreeToggle<CR>

" Syntax highlighting
noremap <unique> <Leader>ny :sy off<CR>
noremap <unique> <Leader>sy :sy on<CR>

" Search
noremap <unique> <Leader>nh :nohlsearch<CR>
noremap <unique> <Leader>sh :set hlsearch<CR>

" Number
noremap <unique> <Leader>nn :set nonumber<CR>
noremap <unique> <Leader>sn :set number<CR>

" Wrap
noremap <unique> <Leader>nw :set nowrap<CR>
noremap <unique> <Leader>sw :set wrap<CR>

" Session
let sessionman_save_on_exit = 1
noremap <unique> <Leader>ss :SessionSave<CR>
noremap <unique> <Leader>sl :SessionList<CR>
noremap <unique> <Leader>so :SessionOpen

" copy past word
noremap <unique> <Leader>c viw"py
noremap <unique> <Leader>v viw"pp

" Make
nnoremap <unique> <Leader>m :!make<CR>

" Resize window
nnoremap <unique> <Leader>= 6<C-w>+
nnoremap <unique> <Leader>- 6<C-w>->
nnoremap <unique> <Leader>[ 8<C-w><
nnoremap <unique> <Leader>] 8<C-w>>

" Invert line
"map <C-f> ddkkp
"map <C-v> ddp

" Comment
map <C-c> ,c j

" Switch window
map <Tab> <C-w>

" Macro
map <F2> @a

" FuzzyFinder
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{},
\                        'MruFile':{}, 'MruCmd':{}, 'Bookmark':{},
\                        'Tag':{}, 'TaggedFile':{},
\                        'GivenFile':{}, 'GivenDir':{},
\                        'CallbackFile':{}, 'CallbackItem':{}, }
let g:FuzzyFinderOptions.Base.ignore_case = 1
let g:FuzzyFinderOptions.Base.min_length = 4
let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.DS_Store$|\.jpg$|\.gif$|\.png$|\.bak$|\.swp$|\.git$|\.svn$|gen'
let g:FuzzyFinderOptions.Base.abbrev_map    = {
\              "^PL" : [
\                  "~/dailymotion/component/dmplayer/src/dmplayer/com/",
\                  "~/dailymotion/component/dmplayer/src/dmplayer/com/**/",
\              ],
\              "^DM" : [
\                  "~/dailymotion/lib/*",
\                  "~/dailymotion/lib/*/*",
\                  "~/dailymotion/lib/DM/Sequence/*",
\                  "~/dailymotion/lib/DM/Sequence/Layer/*",
\              ],
\              "^CSS" : [
\                  "~/dailymotion/css/",
\                  "~/dailymotion/css/**/",
\              ],
\              "^JS" : [
\                  "~/dailymotion/js/",
\                  "~/dailymotion/js/**/",
\              ],
\              "^WI" : [
\                  "~/dailymotion/lib/DM/WidgetV3/",
\                  "~/dailymotion/lib/DM/WidgetV3/**/",
\              ],
\              "^LI" : [
\                  "~/Github/littleWorld/src/",
\                  "~/Github/littleWorld/src/**/",
\              ],
\}

" Taglist
let g:Tlist_Use_Horiz_Window = 0
let g:Tlist_Use_Right_Window = 1
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = 'name'
let Tlist_Ctags_Cmd = "~/bin/ctags"

" pathogen
call pathogen#infect()

" actionscript language
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

" Autocommands
:augroup my_tab
if !exists("autocommands_loaded")
      let autocommands_loaded = 1
      au BufNewFile,BufRead *.* set expandtab
      au BufNewFile,BufRead *.php set shiftwidth=4 softtabstop=4 tabstop=4
      au BufNewFile,BufRead *.html set shiftwidth=4 softtabstop=4 tabstop=4
      au BufNewFile,BufRead *.css set shiftwidth=4 softtabstop=4 tabstop=2 omnifunc=csscomplete#CompleteCSS
      au BufNewFile,BufRead *.js set shiftwidth=4 softtabstop=4 tabstop=4
      au BufNewFile,BufRead *.tpl set shiftwidth=4 softtabstop=4 tabstop=4
      au BufNewFile,BufRead *.phtml set shiftwidth=2 softtabstop=2 tabstop=2 ft=php " all my .phtml files ARE php
      au BufNewFile,BufRead Makefile set noexpandtab
      au BufNewFile,BufRead *.as set ft=actionscript
      au BufNewFile,BufRead *.json set ft=json
endif

autocmd VimLeave * :!clear

