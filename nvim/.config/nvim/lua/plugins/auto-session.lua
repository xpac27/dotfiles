local ok, auto_session = pcall(require, 'auto-session')
if not ok then
  return
end

auto_session.setup({
  auto_restore = false,
  auto_create = false,
  session_lens = {
    picker = 'fzf',
  },
  bypass_save_filetypes = { 'alpha' },
})

vim.api.nvim_create_user_command('SOpen', function(opts)
  local args = vim.trim(opts.args or '')
  if args == '' then
    vim.cmd('AutoSession restore')
  else
    vim.cmd('AutoSession restore ' .. args)
  end
end, {
  nargs = '?',
  complete = 'file',
})

vim.api.nvim_create_user_command('SSave', function(opts)
  local args = vim.trim(opts.args or '')
  if args == '' then
    vim.cmd('AutoSession save')
  else
    vim.cmd('AutoSession save ' .. args)
  end
end, {
  nargs = '?',
  complete = 'file',
})

vim.api.nvim_create_user_command('SSearch', function()
  vim.cmd('AutoSession search')
end, {})
