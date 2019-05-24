" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif




" =========================================================================
" PLUGINS
" =========================================================================


call plug#begin('~/.vim/plugged')


" Magic
" -------------------------------------------------------------------------
" Plug 'valloric/YouCompleteMe', { 'for': ['cpp', 'c'], 'do': './install.py --clang-completer --system-libclang' }
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp', { 'for': ['cpp'] }
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }


" Misc:
" -------------------------------------------------------------------------

" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'honza/vim-snippets'
Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
Plug 'jamessan/vim-gnupg'
Plug 'wgurecky/vimSum'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/tComment'
Plug 'vim-scripts/gtags.vim', { 'for': ['c'] }
Plug 'tpope/vim-eunuch', { 'on' : ['Delete', 'Unlink', 'Move', 'Rename', 'Find'] }
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] } 


" Search
" -------------------------------------------------------------------------

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-scripts/a.vim'
Plug 'easymotion/vim-easymotion'


" Interfaces
" -------------------------------------------------------------------------

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'gcmt/taboo.vim'
Plug 'scrooloose/nerdtree', { 'on' : ['NERDTreeToggle'] }
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'


" Schemes
" -------------------------------------------------------------------------

Plug 'morhetz/gruvbox'


" Syntaxes
" -------------------------------------------------------------------------

Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
" Plug 'kchmck/vim-coffee-script'
" Plug 'jeroenbourgois/vim-actionscript'
" Plug 'yaymukund/vim-rabl'
" Plug 'groenewege/vim-less'
Plug 'tikhomirov/vim-glsl'
" Plug 'tpope/vim-cucumber'
" Plug 'tpope/vim-haml'


call plug#end()
filetype on
syntax enable


packadd termdebug


" =========================================================================
" SETTINGS
" =========================================================================


set path=.,,**,/usr/local/include,/usr/include
set tags=./tags,.tags
set enc=utf-8
set spelllang=en_us
set fileformats=unix,dos,mac
set fillchars=vert:┃ 
set visualbell t_vb=
set sessionoptions+=tabpages,globals
set viminfo=!,'100,h,n~/.viminfo
set history=1000
set undodir=~/.cache/vim/undo
set backupdir=~/.cache/vim/backup
set backupskip+=",*.gpg"
set textwidth=99999
set tabpagemax=999
set showtabline=1
set laststatus=2
set titlestring=(\ %(%{&ft},\ %)%{&ff}%(,\ %{&fenc}%)\ )
set titlelen=100
set mouse-=a
set complete-=i
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
set wildmode=longest,list
set wildignore=*.o,*.so,*.pyc,*.class,*.fasl,*/tmp/*,*.swp,*.zip,*.bak,*.orig,*.jpg,*.png,*.gif,DS_Store,*.sassc,*.pump
set cmdheight=1
set report=999999
set shortmess=IAW
set scrolloff=5
set scrolljump=5
set softtabstop=4
set shiftwidth=4
set tabstop=4
set updatetime=250
set timeoutlen=300
set maxmem=2000000
set maxmemtot=2000000
set backspace=indent,eol,start
set pumheight=15
set rtp+=/usr/local/opt/fzf
set csto=0
set cspc=0
set signcolumn=yes
set nocsverb
set nocompatible
set noswapfile
set noerrorbells
set novisualbell
" set nobackup
" set nowritebackup
set backup
set writebackup
set nolist
set nowrap
set noshowmode
set noruler
set noequalalways
set hidden
set ttyfast
set nolazyredraw
set autoread
set number
set relativenumber
set cursorline
set title
set wildmenu
set mousehide
set smarttab
set expandtab
set shiftround
set smartindent
set splitbelow
set splitright
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set gdefault
set cst
set undofile

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
" let g:netrw_altv=1          " open splits to the right
" let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

if &diff
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
end



" =========================================================================
" AUTO COMMANDS
" =========================================================================


" use tabs in Makefile
au BufNewFile,BufRead Makefile setlocal noexpandtab

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" Make crontab happy
au filetype crontab setlocal nobackup nowritebackup

" Auto open quickfix on make
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

" Check file for changes
au CursorHold * :checktime

" Auto save
" au CursorHold *.cpp,*.h,*.hpp,*.rb nested silent up




" =========================================================================
" MAPPINGS
" =========================================================================


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

" select the current line without indentation
nnoremap vv ^vg_

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

" tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>

" copy/past word
noremap <unique> <Leader>y viw"wy
noremap <unique> <Leader>p viw"wp

" Close QuickFix window
nmap <leader>c :cclose<CR>

" Show local search results in the QuifFix window
nnoremap <leader>/ :vimgrep // %<CR>

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


" Ultisnips
" -------------------------------------------------------------------------
" YouCompleteMe and UltiSnips compatibility.
" let g:UltiSnipsExpandTrigger = '<Right>'
" let g:UltiSnipsJumpForwardTrigger = '<Right>'
" let g:UltiSnipsJumpBackwardTrigger = '<Left>'


" YouCompleteMe
" -------------------------------------------------------------------------
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_collect_identifiers_from_tags_files = 0
" let g:ycm_always_populate_location_list = 0
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_echo_current_diagnostic = 1
" let g:ycm_show_diagnostics_ui = 1
" let g:ycm_filetype_blacklist = {'vim' : 1, 'ruby': 1}
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" " let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
" " let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
" " let g:ycm_key_list_accept_completion = ['<C-y>']
" let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1 }
" let g:ycm_error_symbol = 'x'
" let g:ycm_warning_symbol = '∆'


" T-Comment
" -------------------------------------------------------------------------
nnoremap <C-c> :TComment<CR>j
vnoremap <C-c> :TComment<CR>j


" Git-Gutter
" -------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_realtime =1
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed= '·'
let g:gitgutter_sign_modified_removed= '·'
" hi GitGutterAdd ctermbg=234 ctermfg=238
" hi GitGutterDelete ctermbg=234 ctermfg=238
" hi GitGutterChange ctermbg=234 ctermfg=238
" hi GitGutterChangeDelete ctermbg=234 ctermfg=238


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
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'arrow_right', 'paste' ], [ 'relativepath', 'modified', 'readonly', 'cocstatus'] ],
      \   'right': [ [ 'percent' ], [ 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'readonly', 'relativepath' ] ],
      \   'right': [ ]
      \ },
      \ 'component': {
      \   'arrow_right': '  '
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
\ }




" LSP
" -------------------------------------------------------------------------

if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/home/vinz/.cache/cquery' },
      \ 'whitelist': ['cpp'],
      \ })
endif


" Clang Format
" -------------------------------------------------------------------------

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 0
let g:auto_format_on_insert_leave = 0


" FZF
" -------------------------------------------------------------------------

nmap <C-f> :GitFiles<CR>


" COC
" -------------------------------------------------------------------------

let languageservers = {}
let languageservers['ccls'] = {
    \ 'command': 'ccls',
    \ 'filetypes': ['c', 'cpp'],
    \ 'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
    \ 'initializationOptions': {
    \   'cache': {
    \     'directory': '/home/vinz/.cache/ccls',
	\ 	}
	\ }
\ }

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-snippets',
\]

let g:coc_user_config = {
    \ 'coc.preferences.formatOnSaveFiletypes': ['cpp', 'c'],
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

call SetLocalOptions(bufname("%"))
