local ok, agentic = pcall(require, 'agentic')
if not ok then
  return
end

local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

agentic.setup({
  provider = is_windows and 'opencode-acp' or 'codex-acp',
  windows = {
    position = 'right',
    width = '40%',
    height = '30%',
  },
})

local map = vim.keymap.set
map({ 'n', 'v', 'i' }, '<leader>aa', function()
  agentic.toggle()
end, { silent = true, desc = 'Toggle Agentic Chat' })
map({ 'n', 'v' }, '<leader>ac', function()
  agentic.add_selection_or_file_to_context()
end, { silent = true, desc = 'Add file or selection to Agentic context' })
map({ 'n', 'v', 'i' }, '<leader>an', function()
  agentic.new_session()
end, { silent = true, desc = 'New Agentic Session' })
map('n', '<leader>ar', function()
  agentic.restore_session()
end, { silent = true, desc = 'Restore Agentic Session' })
