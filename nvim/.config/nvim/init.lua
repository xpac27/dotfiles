-- Bootstrap vim-plug
local fn = vim.fn
local plug_path = fn.stdpath('data') .. '/site/autoload/plug.vim'
vim.opt.runtimepath:append(fn.stdpath('data') .. '/site/')

if fn.has('cscope') == 0 then
  vim.g.loaded_gtags_cscope = 1
end

if fn.empty(fn.glob(plug_path)) > 0 then
  if fn.has('win32') == 1 or fn.has('win64') == 1 then
    local ps_cmd = ([[iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni '%s' -Force]]):format(plug_path)
    fn.system({ 'powershell', '-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', ps_cmd, })
  else
    fn.system({ 'curl', '-fLo', plug_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', })
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
vim.cmd("Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master', 'do': ':TSUpdate' }")
vim.cmd("Plug 'MeanderingProgrammer/render-markdown.nvim'")

-- Explorer replacement for netrw
vim.cmd("Plug 'stevearc/oil.nvim'")

-- LSP / completion
vim.cmd("Plug 'neovim/nvim-lspconfig'")
vim.cmd("Plug 'saghen/blink.cmp', { 'tag': 'v1.*' }")

-- Statusline
vim.cmd("Plug 'nvim-lualine/lualine.nvim'")
vim.cmd("Plug 'nanozuki/tabby.nvim'")

-- Motions
vim.cmd("Plug 'folke/flash.nvim'")

-- Startup
vim.cmd("Plug 'goolord/alpha-nvim'")

-- Changes highlight
vim.cmd("Plug 'nvim-mini/mini.diff'")
vim.cmd("Plug 'ofwinterpassed/perfnvim'")

if fn.has('win32') == 1 or fn.has('win64') == 1 then
  vim.g.perforce_open_on_change = 0
  vim.g.perforce_prompt_on_open = 0
  vim.cmd("Plug 'nfvs/vim-perforce'")
end

vim.call('plug#end')
vim.cmd('syntax enable')

require('core.options') -- editor options
require('core.keymaps') -- keybindings
require('core.autocmds') -- autocommands
require('core.abbreviations') -- insert and command abbreviations
require('core.errorformat') -- build and quickfix parsing

local ok_quickfix, quickfix = pcall(require, 'core.quickfix')
if ok_quickfix then
  quickfix.setup() -- async make and quickfix helpers
end

require('plugins.gruvbox') -- colorscheme
require('plugins.fzf-lua') -- fuzzy finder
require('plugins.colorizer') -- color preview
require('plugins.treesitter') -- treesitter
require('plugins.render-markdown') -- markdown rendering
require('plugins.oil') -- file explorer
require('plugins.lsp') -- lsp
require('plugins.blink') -- completion
require('plugins.lualine') -- statusline
require('plugins.tabby') -- tabline
require('plugins.flash') -- motions
require('plugins.alpha') -- startup screen

local Diff = require('mini.diff')
Diff.setup({
  source = {
    require('perfnvim').gen_source_p4(),
    Diff.gen_source.git(),
    Diff.gen_source.save(),
  },
})
