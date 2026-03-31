local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local vinz = augroup('VINZ', { clear = true })
local p4_state = {}

local function read_file_hash(path)
  if path == '' or vim.fn.filereadable(path) ~= 1 then
    return nil
  end

  local stat = vim.uv.fs_stat(path)
  if not stat or stat.type ~= 'file' then
    return nil
  end

  local fd = vim.uv.fs_open(path, 'r', 438)
  if not fd then
    return nil
  end

  local ok, data = pcall(vim.uv.fs_read, fd, stat.size, 0)
  vim.uv.fs_close(fd)

  if not ok or type(data) ~= 'string' then
    return nil
  end

  return vim.fn.sha256(data)
end

local function capture_p4_baseline(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == '' then
    p4_state[bufnr] = nil
    return nil
  end

  local baseline = {
    path = path,
    hash = read_file_hash(path),
  }

  p4_state[bufnr] = baseline
  return baseline
end

local function clear_p4_state(bufnr)
  p4_state[bufnr] = nil
end

autocmd('CursorHold', {
  group = vinz,
  pattern = '*',
  command = 'checktime',
})

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  autocmd('FileChangedRO', {
    group = vinz,
    pattern = '*',
    callback = function(args)
      -- Capture the pre-checkout disk contents so FileChangedShell can later
      -- tell whether Neovim only observed the expected `p4 edit` metadata
      -- update or a real external content change.
      capture_p4_baseline(args.buf)

      vim.cmd('silent! P4edit')

      local file = vim.api.nvim_buf_get_name(args.buf)
      if file ~= '' and vim.fn.filewritable(file) == 1 then
        vim.bo[args.buf].readonly = false

        -- Force Neovim to acknowledge the post-checkout file state
        -- immediately, before the buffer becomes modified.
        vim.api.nvim_buf_call(args.buf, function()
          vim.cmd('silent! checktime')
        end)
      else
        clear_p4_state(args.buf)
      end
    end,
  })

  autocmd('FileChangedShell', {
    group = vinz,
    pattern = '*',
    callback = function(args)
      local state = p4_state[args.buf]
      if not state then
        vim.v.fcs_choice = 'ask'
        return
      end

      local file = vim.api.nvim_buf_get_name(args.buf)
      local writable = file ~= '' and vim.fn.filewritable(file) == 1
      local same_file = file ~= '' and file == state.path
      local same_hash = same_file and read_file_hash(file) == state.hash

      -- If the file became writable and the on-disk contents still match the
      -- pre-checkout snapshot, this is the expected Perforce checkout side
      -- effect. Suppress the prompt while keeping real content changes visible.
      if writable and same_hash then
        vim.bo[args.buf].readonly = false
        vim.v.fcs_choice = vim.bo[args.buf].modified and '' or 'reload'
        clear_p4_state(args.buf)
        return
      end

      vim.v.fcs_choice = 'ask'
    end,
  })

  autocmd({ 'FileChangedShellPost', 'BufReadPost', 'BufWritePost', 'BufUnload', 'BufWipeout' }, {
    group = vinz,
    pattern = '*',
    callback = function(args)
      clear_p4_state(args.buf)
    end,
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
