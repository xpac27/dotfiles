local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local vinz = augroup('VINZ', { clear = true })
autocmd('CursorHold', {
  group = vinz,
  pattern = '*',
  command = 'checktime',
})

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  autocmd('FileChangedRO', {
    group = vinz,
    pattern = '*',
    command = 'silent! P4edit',
  })
  autocmd('FileChangedShell', {
    group = vinz,
    pattern = '*',
    command = [[echohl WarningMsg | echo "File changed shell." | echohl None]],
  })
end

autocmd('FileType', {
  pattern = { 'c', 'cpp', 'cs', 'ddf', 'proto' },
  callback = function()
    vim.opt_local.commentstring = '// %s'
  end,
})
autocmd('FileType', {
  pattern = 'tup',
  callback = function()
    vim.opt_local.commentstring = '" %s'
  end,
})
