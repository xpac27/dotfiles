local ok, oil = pcall(require, 'oil')
if not ok then
  return
end

oil.setup({
  default_file_explorer = true,
  delete_to_trash = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = false,
    natural_order = true,
  },
  float = {
    max_width = 0.6,
    max_height = 0.8,
    border = 'rounded',
  },
})

vim.keymap.set('n', '<leader>dd', '<CMD>Oil --float<CR>', { desc = 'Open file explorer (float)' })
vim.keymap.set('n', '<leader>da', '<CMD>Oil<CR>', { desc = 'Open file explorer' })
