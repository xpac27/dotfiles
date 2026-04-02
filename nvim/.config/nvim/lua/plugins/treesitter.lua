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
})
