" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'honza/vim-snippets'
Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
Plug 'jamessan/vim-gnupg'
Plug 'wgurecky/vimSum'
Plug 'mhinz/vim-startify'
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] } 
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-scripts/a.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'gcmt/taboo.vim'
Plug 'scrooloose/nerdtree', { 'on' : ['NERDTreeToggle'] }
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'morhetz/gruvbox'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-commentary'
" Plug 'kchmck/vim-coffee-script'
" Plug 'jeroenbourgois/vim-actionscript'
" Plug 'yaymukund/vim-rabl'
" Plug 'groenewege/vim-less'
Plug 'tikhomirov/vim-glsl'
" Plug 'tpope/vim-cucumber'
" Plug 'tpope/vim-haml'
Plug 'dag/vim-fish'

call plug#end()
filetype on
syntax enable

set autoread
set backspace=indent,eol,start
set backup
set backupdir=~/.cache/vim/backup
set backupskip+=",*.gpg"
set cmdheight=1
set complete-=i
set completeopt=longest,menuone
set cursorline
set enc=utf-8
set expandtab
set fileformats=unix,dos,mac
set fillchars=vert:┃ 
set gdefault
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set mouse-=a
set mousehide
set equalalways
set noerrorbells
set nohidden
set lazyredraw
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
set report=999999
set scrolljump=5
set scrolloff=5
set sessionoptions+=tabpages,globals
set shiftround
set shiftwidth=4
set shortmess=IAW
set showmatch
set showtabline=1
set sidescrolloff=5
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set softtabstop=4
set spelllang=en_us
set splitbelow
set splitright
set tabpagemax=999
set tabstop=4
set tags=./tags,.tags
set textwidth=99999
set timeoutlen=300
set title
set titlelen=100
set titlestring=(\ %(%{&ft},\ %)%{&ff}%(,\ %{&fenc}%)\ )
set undodir=~/.cache/vim/undo
set undofile
set updatetime=300
set visualbell t_vb=
set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc,*.pump
set wildmenu
set wildmode=longest,list
set writebackup

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if &diff
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
end

" disable annoying banner
let g:netrw_banner=0

" Check file for changes
au CursorHold * :checktime

" use tabs in Makefile
au BufNewFile,BufRead Makefile setlocal noexpandtab

" Make crontab happy
au filetype crontab setlocal nobackup nowritebackup

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Auto save
" au CursorHold *.c,*.h,*.cpp,*.h,*.hpp,*.rb nested silent up

" typos
ia   feild    field
ia   flase    false
ia   lenght   length
ia   toogle   toggle
ia   wiht     with
ia   heigth   height
ia   retrun   return
ia   being    begin

" shortcuts
ab   fu   function
ab   pr   private
ab   pt   protected
ab   pu   public

" save time
nnoremap ; :

" don't lose selection after indenting
vnoremap < <gv
vnoremap > >gv

" Clear search
nnoremap <silent> _ :nohl<CR>

" Only higlight on #
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" toggle options
nnoremap <silent> <leader>op :set paste!<CR>
nnoremap <silent> <leader>on :set number!<CR>
nnoremap <silent> <leader>or :set relativenumber!<CR>
nnoremap <silent> <leader>ow :set wrap!<CR>
nnoremap <silent> <leader>ol :set list!<CR>
nnoremap <silent> <leader>os :setl spell!<CR>
nnoremap <silent> <leader>od :e ++ff=dos<CR>:setlocal ff=dos<CR>

" Avoid unintentional switches to Ex mode.
nmap Q q

" Not usefull
nmap K <nop>
nmap <C-s> <nop>
nmap ^S <nop>

 " Repurpose cursor keys
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :lprevious<CR>
nnoremap <silent> <Right> :lnext<CR>




" =========================================================================
" COMMANDS
" =========================================================================


" JSON
" -------------------------------------------------------------------------
if executable('python')
    command! JSON :%!python -m json.tool
endif


" FZF
" -------------------------------------------------------------------------
if executable('rg')
  command! -complete=dir -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.<q-args>, 1, <bang>0)
endif


" Async MAKE
" -------------------------------------------------------------------------
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>




" =========================================================================
" PLUGINS
" =========================================================================


" Gruvbox
" -------------------------------------------------------------------------
set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_italic=0
let g:gruvbox_invert_selection=0
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_vert_split="bg0"
let g:gruvbox_sign_column="bg0"
let g:gruvbox_color_column="bg0"
set background=dark
colorscheme gruvbox
" hi VertSplit guifg=#504945
" hi ColorColumn guibg=#3c3836
" hi Search guifg=#666666 guibg=#ffffff
hi CocHighlightText guibg=#665c54


" AsyncRun
" -------------------------------------------------------------------------
let g:asyncrun_open = 8
let g:asyncrun_save = 2
let g:asyncrun_local = 1
let g:asyncrun_exit = "if g:asyncrun_code == 0 | cclose | endif"


" Git-Gutter
" -------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_realtime =1
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed= '·'
let g:gitgutter_sign_modified_removed= '·'


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


" EasyMotion
" -------------------------------------------------------------------------
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1


" Taboo
" -------------------------------------------------------------------------
let g:taboo_tab_format = ' %f%m '


" NERDTree
" -------------------------------------------------------------------------
let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=2


" Lightline
" -------------------------------------------------------------------------
      " \ 'colorscheme': 'PaperColor_light',
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'arrow_right', 'paste' ], [ 'relativepath', 'modified', 'readonly', 'cocstatus'] ],
      \   'right': [ [ 'percent' ], [ 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'readonly', 'relativepath' ] ],
      \   'right': [ ]
      \ },
      \ 'component': {
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
\ }


" Clang Format
" -------------------------------------------------------------------------

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#enable_fallback_style = 0


" FZF
" -------------------------------------------------------------------------

nmap <C-f> :GitFiles<CR>


" COC
" -------------------------------------------------------------------------

let languageservers = {}
let languageservers['clangd'] = {
    \ 'command': 'clangd',
    \ 'args': ['-background-index', '--clang-tidy'],
    \ 'filetypes': ['c', 'cpp'],
    \ 'rootPatterns': ['compile_flags.txt', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
\ }

" let languageservers['ccls'] = {
"     \ 'command': 'ccls',
"     \ 'filetypes': ['c', 'cpp'],
"     \ 'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
"     \ 'initializationOptions': {
"     \   'cache': {
"     \     'directory': '/home/vinz/.cache/ccls',
" 	\ 	}
" 	\ }
" \ }

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-snippets',
\]

let g:coc_user_config = {
    \ 'coc.preferences.formatOnSaveFiletypes': [],
    \ 'diagnostic.enable': v:true,
    \ 'diagnostic.enableMessage': 'always',
    \ 'languageserver': languageservers,
    \ 'diagnostic.errorSign': 'x',
    \ 'diagnostic.warningSign': '∆',
    \ 'diagnostic.infoSign': '➤',
    \ 'diagnostic.hintSign': '➤',
    \ 'suggest.snippetIndicator': ' ⚡',
    \ 'snippets.ultisnips.enable': v:false,
    \ 'snippets.ultisnips.directories': ['/home/vinz/.vim/plugged/vim-snippets/snippets'],
\ }

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>




" =========================================================================
" LOCAL VIMRC
" =========================================================================

function! SetLocalOptions(fname)
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

call SetLocalOptions(bufname("%"))
