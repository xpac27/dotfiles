" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath

let plug_path = stdpath('data') . '/site/autoload/plug.vim'

if has("unix")
    if empty(glob(plug_path))
        silent execute '!curl -fLo ' . shellescape(plug_path) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }
Plug 'neovim/nvim-lspconfig'
call plug#end()

lua require('lsp')
lua require('blink')

