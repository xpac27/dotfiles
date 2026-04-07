local map = vim.keymap.set

local function token_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local left = col
  local right = col

  while left > 1 and not line:sub(left - 1, left - 1):match('%s') do
    left = left - 1
  end

  while right <= #line and not line:sub(right, right):match('%s') do
    right = right + 1
  end

  return line:sub(left, right - 1)
end

local function gf_with_line_col()
  local token = token_under_cursor():gsub('^[`%[(<"\']+', ''):gsub('[`%])>,;"\']+$', '')
  local path, lnum, col = token:match('^(.-):(%d+):(%d+)$')

  if not path then
    path, lnum = token:match('^(.-):(%d+)$')
  end

  if not path or path == '' then
    vim.cmd.normal({ 'gf', bang = true })
    return
  end

  local escaped = vim.fn.fnameescape(path)
  local found = vim.fn.findfile(path, vim.o.path)

  if found == '' and vim.fn.filereadable(path) == 0 then
    vim.cmd.normal({ 'gf', bang = true })
    return
  end

  vim.cmd('edit ' .. vim.fn.fnameescape(found ~= '' and found or path))

  if lnum then
    vim.api.nvim_win_set_cursor(0, { tonumber(lnum), math.max((tonumber(col) or 1) - 1, 0) })
  end
end

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '_', ':nohl<CR>', { silent = true })
map('n', '#', [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]])
map('n', 'gf', gf_with_line_col, { silent = true })

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
  local ok, quickfix = pcall(require, 'core.quickfix')
  if ok then
    quickfix.toggle_quickfix()
  end
end, { silent = true })
map('n', '<leader>qq', ':cex []<CR>')
map('n', '<leader>m', ':Make test NO_COLOR=1<CR>', { silent = true })
map('n', '<leader>d', function()
  MiniDiff.toggle_overlay()
end, { silent = true })
map('n', '<leader>r', [[:%s/\<<C-R><C-W>\>//gc<left><left><left>]])
map('n', 'cp', [[:let @+ = expand('%')<CR>]])

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  -- Windows Terminal sends the same keycode for <Tab> and <C-I>, which breaks
  -- Neovim's default jumplist-forward on <C-I> when <Tab> is mapped elsewhere.
  -- Work around it by mapping ctrl+i in WT to send <M-I> via sendInput, e.g.:
  -- { "keys": "ctrl+i", "id": "User.sendInput.B502FD5" }
  -- { "command": { "action": "sendInput", "input": "\u001b[73;3u" }, "id": "User.sendInput.B502FD5" }
  map('n', '<M-I>', '<C-I>', { silent = true, desc = 'Jump forward' })
  map('n', '<leader>m', ':Ninja<CR>', { silent = true })
  map('n', '<leader>mm', ':NinjaAll<CR>', { silent = true })
  map('n', '<leader>t', ':Test<CR>', { silent = true })
  map('n', '<leader>tt', ':TestAll<CR>', { silent = true })
end

if vim.fn.executable('python') == 1 then
  vim.api.nvim_create_user_command('JSON', '%!python -m json.tool', {})
end
