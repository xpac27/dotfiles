local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup({
  ensure_installed = {
    'markdown',
    'markdown_inline',
    'html',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<Tab>',
      node_incremental = '<Tab>',
      scope_incremental = '<S-Tab>',
      node_decremental = '<BS>',
    },
  },
})
