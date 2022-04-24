if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'gregsexton/MatchTag', { 'for': ['html'] }
Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'

if &diff
else
    Plug 'jamessan/vim-gnupg'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': ['c', 'cpp'] }
    " Plug 'ycm-core/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': 'python install.py --clangd-completer' }
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }
    Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
    Plug 'derekwyatt/vim-fswitch', { 'for': ['c', 'cpp'] }

    if has("win32")
        Plug 'nfvs/vim-perforce'
    endif
end

if has("unix")
    Plug 'direnv/direnv.vim'
endif

call plug#end()

filetype on
syntax enable

set exrc
set autoread
set backspace=indent,eol,start
set cmdheight=2
set complete-=i
set completeopt=longest,menuone
set cryptmethod=blowfish2
set cursorline
set encoding=UTF-8
set equalalways
set expandtab
set fileformats=unix,dos,mac
set fillchars=vert:┃ 
set gdefault
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set mouse-=a
set mousehide
set noerrorbells
set nolist
set nomodeline " disabled for security
set noruler
set noshowmode
set noswapfile
set novisualbell
set nowrap
set number
set path=.,,**,/usr/local/include,/usr/include
set pumheight=15
set relativenumber
set scrolljump=5
set scrolloff=5
set shiftround
set shiftwidth=4
set shortmess=IAW
set showmatch
set showtabline=1
set sidescrolloff=5
set smartcase
set smartindent
set smarttab
set softtabstop=4
set spelllang=en_us
set splitbelow
set splitright
set tabpagemax=999
set tabstop=4
set termguicolors
set tags=./tags,.tags,tags
set textwidth=99999
set timeoutlen=300
set undodir=~/.cache/vim/undo
set backupdir=~/.cache/vim/backup
set backupskip+=",*.gpg"
set undofile
set undolevels=1000
set undoreload=1000
set updatetime=300
set wildignore=*.o,*.dwo,*.so,*.pyc,*.swp,*.orig,DS_Store
set wildmenu
set wildmode=longest,list
set nofixendofline
set backup
set writebackup

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if exists('theme') && theme == 'light'
    set background=light
else
    set background=dark
endif

if &diff
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
end

" disable annoying banner
let g:netrw_banner=0

augroup VINZ
    autocmd!

    " Check file for changes
    au CursorHold * :checktime

    " Auto open quickfix on make
    " au QuickFixCmdPost [^l]* nested cwindow
    " au QuickFixCmdPost l* nested lwindow
augroup END

" typos
ia   feild    field
ia   flase    false
ia   lenght   length
ia   toogle   toggle
ia   wiht     with
ia   widht    width
ia   heigth   height
ia   retrun   return
ia   easlt    eastl
ia   being    begin
ia   frist    first

" shortcuts
ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public
ab   st   static
ab   cl   console.log

" don't lose selection after indenting
vnoremap < <gv
vnoremap > >gv

" Clear search
nnoremap <silent> _ :nohl<CR>

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Toggle options
nnoremap <silent> <leader>op :set paste!<CR>
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>os :setl spell!<CR>
nnoremap <silent> <leader>od :e ++ff=dos<CR>:setlocal ff=dos<CR>

" Not usefull
nnoremap Q q
nnoremap K <nop>
nnoremap <C-s> <nop>
nnoremap ^S <nop>

" Repurpose cursor keys
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :lprevious<CR>
nnoremap <silent> <Right> :lnext<CR>

" Replace word under cursor
nnoremap <leader>r :%s/\<<C-R><C-W>\>//gc<left><left><left>

" Close QuickFix and LocationList window
nnoremap <leader>c :cclose<CR>:lclose<CR>

" Copy filepath
nnoremap cp :let @+ = expand("%")<cr>

" JSON
if executable('python')
    command! JSON :%!python -m json.tool
endif

" Others
if has("unix")
    command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
else
    command! Compile AsyncRun compile.rb %:p
    command! CompileProject AsyncRun compile.rb %:p:h
    command! CompileSolution AsyncRun compile.rb
    command! RemoveFromMaster AsyncRun -silent compile.rb REMOVE_FROM_MASTER %:p
	command! DicePersistenceTests AsyncRun D:\kingston\dev\TnT\Local\Bin\Win64-Dll\release\Extension.DicePersistence.Test_Win64_release_Dll.exe
endif

