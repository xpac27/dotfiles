if has("unix")
    if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif
endif

call plug#begin('~/.vim/plugged')

" UI
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'itchyny/lightline.vim'
" Plug 'airblade/vim-gitgutter'

" Textual helpers
Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'xml'] }
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'tpope/vim-abolish', { 'on': 'Abolish' }
Plug 'tpope/vim-commentary'

" Navigation
Plug 'easymotion/vim-easymotion'

" Copilot
Plug 'github/copilot.vim'

" Themes
Plug 'Lokaltog/vim-monotone'
" Plug 'morhetz/gruvbox'
" Plug 'sainnhe/gruvbox-material'
" Plug 'shinchu/lightline-gruvbox.vim'

if &diff
else
    " Highlights
    Plug 'ap/vim-css-color'

    " Encryption
    Plug 'jamessan/vim-gnupg'

    " Search
    " Plug 'junegunn/fzf', { 'tag': '0.52.1' }
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " Undo
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

    " Startup
    Plug 'mhinz/vim-startify'

    " LSP (old)
    " Plug 'neoclide/coc.nvim', { for': ['cpp', 'c'], 'branch': 'release' }
    " Plug 'ycm-core/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': 'python install.py --clangd-completer' }

    " LSP
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " Quickfix
    Plug 'Valloric/ListToggle'
    Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }

    " Location
    Plug 'farmergreg/vim-lastplace'

    " Perforce
    if has('win64') || has('win32')
        Plug 'nfvs/vim-perforce'
        "Plug 'ngemily/vim-vp4'
    endif
end

call plug#end()

if has('win64') || has('win32')
    set pythonthreehome=~\AppData\Local\Programs\Python\Python311-32
    set pythonthreedll=~\AppData\Local\Programs\Python\Python311-32\python311.dll

    " Silence the warning that's emitted first time python3 is run
    if has('python3')
        silent! python3 1
    endif
endif

filetype on
syntax enable

colorscheme monotone

" hide files in explore mode
let g:netrw_list_hide = '\.o$,\.d$,\.a$,\.so$,\.swp$,\.orig$,\.pyc$'
let g:netrw_liststyle = 3
let g:netrw_sort_by = "name"
let g:netrw_sort_sequence = "[\/]$"
let g:netrw_hide = 1
let g:netrw_fastbrowse = 0

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" escape sequences for undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

if has('win64') || has('win32')
    set listchars=lead:\:
    set listchars+=trail:· 
    set listchars+=tab:\ \ 
else
    set listchars=tab:»- 
    set listchars+=trail:· 
endif

set exrc
set autoread
set backspace=indent,eol,start
set cmdheight=1
set complete-=i
set completeopt=longest,menuone
set cryptmethod=blowfish2
set cursorline
set encoding=UTF-8
set equalalways
set expandtab
set formatoptions=vtr
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
set mouse=a
set mousehide
set noerrorbells
set nolist
set list 
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
set shortmess=at
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
set wildignore=*.o,*.d,*.a,*.so,*.pyc,*.swp,*.orig
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

augroup VINZ
    autocmd!

    " Check file for changes
    au CursorHold * :checktime

    " Auto open quickfix on make
    " au QuickFixCmdPost [^l]* nested cwindow
    " au QuickFixCmdPost l* nested lwindow

    if has('win64') || has('win32')
        au FileChangedRO * silent! :P4edit
        au FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None
    endif
augroup END

" typos
ia  feild      field
ia  flase      false
ia  lenght     length
ia  toogle     toggle
ia  wiht       with
ia  widht      width
ia  heigth     height
ia  retrun     return
ia  easlt      eastl
ia  being      begin
ia  frist      first
ia  reffer     refer
ia  repporting reporting
ia  nulltpr	   nullptr

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
nnoremap <C-w>o <nop>

" Repurpose cursor keys
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
nnoremap <silent> <Up> :Cprev<CR>
nnoremap <silent> <Down> :Cnext<CR>

" Replace word under cursor
nnoremap <leader>r :%s/\<<C-R><C-W>\>//gc<left><left><left>

" Copy filepath
nnoremap cp :let @+ = expand("%")<cr>

" JSON
if executable('python')
    command! JSON :%!python -m json.tool
endif

" Others
if has("unix")
    command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

    nnoremap <silent> <leader>m :Make test<CR>

    " Greatest
    set errorformat+=FAIL\ %m\ (%f:%l)
else
    command! Ninja AsyncRun -strip ruby C:\Users\vcogne\bin\compile.rb NINJA_BUILD %:t
    command! NinjaBO AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb NINJA_BUILD BattlefieldOnline
    command! NinjaAll AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb NINJA_BUILD

    command! Test AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb NINJA_TEST %:p line('.')
    command! IntTest AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb NINJA_INT_TEST
    command! UnitTest AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb NINJA_UNIT_TEST

    command! Compile AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb %:p
    command! CompileProject AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb %:p:h
    command! CompileSolution AsyncRun -strip  ruby C:\Users\vcogne\bin\compile.rb

    command! RemoveFromMaster AsyncRun -silent ruby C:\Users\vcogne\bin\compile.rb REMOVE_FROM_MASTER %:p

    nnoremap <silent> <leader>m :Ninja<CR>
    nnoremap <silent> <leader>t :Test<CR>

    nnoremap <leader>s :P4edit "%"<CR>:AsyncRun -silent fb sort_includes %:p<CR>

    " Reset error format
    set errorformat=

    " MSVC error format
    set errorformat+=%f(%l\\,%c):\ %m
    set errorformat+=%f(%l)\ :\ %m

    " DDC error format
    set errorformat+=%f(%l,%c):\ %m

    " Gtest error format
    set errorformat+=%f(%l):\ %m
endif

