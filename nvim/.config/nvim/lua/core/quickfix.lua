local M = {}

local qf_height = 20

local function set_qf_lines(lines, title)
  vim.fn.setqflist({}, 'r', {
    title = title,
    lines = lines,
  })
end

local function qf_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.fn.getwininfo(win)[1].quickfix == 1 then
      return true
    end
  end
  return false
end

local function loc_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local info = vim.fn.getwininfo(win)[1]
    if info.quickfix == 1 and info.loclist == 1 then
      return true
    end
  end
  return false
end

function M.toggle_quickfix()
  if qf_is_open() then
    vim.cmd('cclose')
  else
    vim.cmd(qf_height .. 'copen')
  end
end

function M.toggle_loclist()
  if loc_is_open() then
    vim.cmd('lclose')
  else
    vim.cmd(qf_height .. 'lopen')
  end
end

function M.run_to_qf(cmd, opts)
  opts = opts or {}

  local lines = {}
  local title = opts.title or table.concat(cmd, ' ')

  vim.fn.setqflist({}, ' ', {
    title = title,
    items = {},
  })

  local function refresh()
    set_qf_lines(lines, title)
  end

  local function on_output(_, data)
    if not data then
      return
    end
    for _, line in ipairs(data) do
      line = line:gsub('\r$', '')
      if line ~= '' then
        table.insert(lines, line)
      end
    end
    refresh()
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = on_output,
    on_stderr = on_output,
    on_exit = function(_, code)
      refresh()
      vim.schedule(function()
        if code == 0 then
          vim.cmd('cclose')
        else
          vim.cmd(qf_height .. 'copen')
          vim.cmd('wincmd w')
        end
      end)
    end,
  })
end

function M.setup()
  if vim.fn.has('unix') == 1 then
    vim.api.nvim_create_user_command('Make', function(opts)
      local cmd = { 'make' }
      vim.list_extend(cmd, opts.fargs)
      M.run_to_qf(cmd, {
        title = 'make ' .. table.concat(opts.fargs, ' '),
      })
    end, {
      bang = true,
      nargs = '*',
      complete = 'file',
    })
  else
    vim.api.nvim_create_user_command('Ninja', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_BUILD',
        vim.fn.expand('%:p'),
      }, {
        title = 'Ninja',
      })
    end, {})

    vim.api.nvim_create_user_command('NinjaBO', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_BUILD',
        'Extension.BattlefieldOnline_all',
      }, {
        title = 'NinjaBO',
      })
    end, {})

    vim.api.nvim_create_user_command('NinjaAll', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_BUILD',
        'all',
      }, {
        title = 'NinjaAll',
      })
    end, {})

    vim.api.nvim_create_user_command('Test', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_TEST',
        vim.fn.expand('%:p'),
      }, {
        title = 'Test',
      })
    end, {})

    vim.api.nvim_create_user_command('TestAll', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_TEST',
        vim.fn.expand('%:p'),
      }, {
        title = 'TestAll',
      })
    end, {})

    vim.api.nvim_create_user_command('IntTest', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_INT_TEST',
      }, {
        title = 'IntTest',
      })
    end, {})

    vim.api.nvim_create_user_command('UnitTest', function()
      M.run_to_qf({
        'ruby',
        [[E:\Gitlab\scripts\compile.rb]],
        'NINJA_UNI_TEST',
      }, {
        title = 'UnitTest',
      })
    end, {})
  end

  vim.api.nvim_create_user_command('Run', function(opts)
    if #opts.fargs == 0 then
      return
    end
    M.run_to_qf(opts.fargs, {
      title = table.concat(opts.fargs, ' '),
    })
  end, {
    nargs = '+',
    complete = 'file',
  })

  local qf = vim.api.nvim_create_augroup('VINZ_quickfix', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = qf,
    pattern = 'qf',
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.list = false
      vim.opt_local.cursorline = true
      vim.opt_local.fillchars = 'eob: '
      vim.wo.winhighlight = 'Normal:QuickFixBackground,EndOfBuffer:QFEndOfBuffer'
    end,
  })

  if vim.fn.has('unix') == 1 then
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = qf,
      pattern = '*.c',
      command = 'Make test NO_COLOR=1',
    })
  end
end

return M
