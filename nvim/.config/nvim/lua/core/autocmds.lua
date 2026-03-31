local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local now = vim.uv and vim.uv.now or vim.loop.now

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
    callback = function(args)
      -- vim-perforce handles the actual checkout via its own FileChangedRO
      -- autocmd. We only mark a short window so the follow-up file attribute
      -- change from `p4 edit` can be treated as expected, not as a conflict.
      vim.b[args.buf].p4_checkout_pending_until = now() + 2000
    end,
  })

  autocmd('FileChangedShell', {
    group = vinz,
    pattern = '*',
    callback = function(args)
      local file = vim.api.nvim_buf_get_name(args.buf)
      local writable = file ~= '' and vim.fn.filewritable(file) == 1
      local reason = vim.v.fcs_reason
      local pending_until = vim.b[args.buf].p4_checkout_pending_until or 0
      local from_p4_checkout = pending_until > now()

      -- Perforce checkout often flips file mode/timestamp under Neovim. If the
      -- file is now writable, clear the buffer's readonly flag and suppress the
      -- built-in prompt for these metadata-only changes.
      if writable and (reason == 'mode' or reason == 'time') then
        vim.bo[args.buf].readonly = false
        vim.v.fcs_choice = ''
        return
      end

      -- Some setups report the checkout as a content/conflict change even
      -- though it is just the immediate `p4 edit` side effect. Suppress that
      -- prompt only inside the short checkout window above.
      if from_p4_checkout and writable and (reason == 'changed' or reason == 'conflict') then
        vim.bo[args.buf].readonly = false
        vim.v.fcs_choice = ''
        return
      end

      -- Anything else could be a real external edit, so keep Neovim's prompt.
      vim.v.fcs_choice = 'ask'
    end,
  })

  autocmd('FileChangedShellPost', {
    group = vinz,
    pattern = '*',
    callback = function(args)
      -- Clear the temporary marker once Neovim finishes handling the external
      -- change notification.
      vim.b[args.buf].p4_checkout_pending_until = nil
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
