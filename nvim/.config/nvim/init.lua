-- Bootstrap vim-plug
local fn = vim.fn
local plug_path = fn.stdpath('data') .. '/site/autoload/plug.vim'

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

-- Theme (temporary)
vim.cmd("Plug 'morhetz/gruvbox'")

-- Search / picker
vim.cmd("Plug 'ibhagwan/fzf-lua'")
vim.cmd("Plug 'nvim-tree/nvim-web-devicons'")

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

require('core.options')
require('core.keymaps')
require('core.autocmds')
require('core.abbreviations')
require('core.errorformat')

require('plugins.gruvbox')
require('plugins.fzf-lua')
require('plugins.oil')
require('plugins.lsp')
require('plugins.blink')
require('plugins.lualine')
require('plugins.flash')
require('plugins.alpha')
