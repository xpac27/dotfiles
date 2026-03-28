-- Bootstrap vim-plug
local fn = vim.fn
local plug_path = fn.stdpath('data') .. '/site/autoload/plug.vim'

if fn.has('cscope') == 0 then
  vim.g.loaded_gtags_cscope = 1
end

if fn.empty(fn.glob(plug_path)) > 0 then
  if fn.has('win32') == 1 or fn.has('win64') == 1 then
    local ps_cmd = ([[iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni '%s' -Force]]):format(plug_path)
    fn.system({
      'powershell',
      '-NoProfile',
      '-ExecutionPolicy',
      'Bypass',
      '-Command',
      ps_cmd,
    })
  else
    fn.system({
      'curl',
      '-fLo',
      plug_path,
      '--create-dirs',
      'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
    })
  end

  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.cmd('PlugInstall --sync')
    end,
  })
end

vim.call('plug#begin', fn.stdpath('data') .. '/plugged')

-- Core UI / helpers
vim.cmd("Plug 'jeffkreeftmeijer/vim-numbertoggle'")
vim.cmd("Plug 'tpope/vim-commentary'")
vim.cmd("Plug 'wfxr/protobuf.vim'")
vim.cmd("Plug 'farmergreg/vim-lastplace'")

-- Search / picker
vim.cmd("Plug 'ibhagwan/fzf-lua'")
vim.cmd("Plug 'nvim-tree/nvim-web-devicons'")
vim.cmd("Plug 'catgoose/nvim-colorizer.lua'")

-- Explorer replacement for netrw
vim.cmd("Plug 'stevearc/oil.nvim'")

-- LSP / completion
vim.cmd("Plug 'neovim/nvim-lspconfig'")
vim.cmd("Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }")

-- Statusline
vim.cmd("Plug 'nvim-lualine/lualine.nvim'")

-- Motions
vim.cmd("Plug 'folke/flash.nvim'")

-- Startup
vim.cmd("Plug 'goolord/alpha-nvim'")

vim.call('plug#end')

require('core.options') -- editor options
require('core.keymaps') -- keybindings
require('core.autocmds') -- autocommands
require('core.abbreviations') -- insert and command abbreviations
require('core.errorformat') -- build and quickfix parsing

require('plugins.gruvbox') -- colorscheme
require('plugins.fzf-lua') -- fuzzy finder
require('plugins.colorizer') -- color preview
require('plugins.oil') -- file explorer
require('plugins.lsp') -- lsp
require('plugins.blink') -- completion
require('plugins.lualine') -- statusline
require('plugins.flash') -- motions
require('plugins.alpha') -- startup screen
