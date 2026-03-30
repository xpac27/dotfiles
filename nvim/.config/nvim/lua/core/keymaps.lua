local map = vim.keymap.set

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '_', ':nohl<CR>', { silent = true })
map('n', '#', [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]])

map('n', '<leader>op', ':set paste!<CR>', { silent = true })
map('n', '<leader>on', ':set number!<CR>', { silent = true })
map('n', '<leader>or', ':set relativenumber!<CR>', { silent = true })
map('n', '<leader>ow', ':set wrap!<CR>', { silent = true })
map('n', '<leader>ol', ':set list!<CR>', { silent = true })
map('n', '<leader>os', ':setlocal spell!<CR>', { silent = true })
map('n', '<leader>od', ':e ++ff=dos<CR>:setlocal ff=dos<CR>', { silent = true })

map('n', 'Q', 'q')
map('n', 'K', '<nop>')
map('n', '<C-s>', '<nop>')
map('n', '^S', '<nop>')
map('n', '<C-w>o', '<nop>')

vim.api.nvim_create_user_command('Cnext', 'try | cnext | catch | cfirst | catch | endtry', {})
vim.api.nvim_create_user_command('Cprev', 'try | cprev | catch | clast | catch | endtry', {})
vim.api.nvim_create_user_command('Lnext', 'try | lnext | catch | lfirst | catch | endtry', {})
vim.api.nvim_create_user_command('Lprev', 'try | lprev | catch | llast | catch | endtry', {})

map('n', '<Up>', ':Cprev<CR>', { silent = true })
map('n', '<Down>', ':Cnext<CR>', { silent = true })
map('n', '<leader>q', function()
  require('core.quickfix').toggle_quickfix()
end, { silent = true })
map('n', '<leader>qq', ':cex []<CR>')
map('n', '<leader>m', ':Make test NO_COLOR=1<CR>', { silent = true })
map('n', '<leader>r', [[:%s/\<<C-R><C-W>\>//gc<left><left><left>]])
map('n', 'cp', [[:let @+ = expand('%')<CR>]])

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  map('n', '<leader>m', ':Ninja<CR>', { silent = true })
  map('n', '<leader>mm', ':NinjaAll<CR>', { silent = true })
  map('n', '<leader>t', ':Test<CR>', { silent = true })
  map('n', '<leader>tt', ':TestAll<CR>', { silent = true })
end

if vim.fn.executable('python') == 1 then
  vim.api.nvim_create_user_command('JSON', '%!python -m json.tool', {})
end
