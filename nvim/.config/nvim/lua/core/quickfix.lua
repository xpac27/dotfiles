local M = {}

local qf_height = 20
local qf_cursor_ns = vim.api.nvim_create_namespace('vinz_quickfix_cursorline')
local qf_ai_ns = vim.api.nvim_create_namespace('vinz_quickfix_ai')
local qf_ai_state = {
  cache = {},
  current_hash = nil,
  prompt_hash = nil,
  bufnr = nil,
  winid = nil,
}
local qf_ai_sidebar_width = 60

local function list_items(info)
  if info.quickfix == 1 then
    return vim.fn.getqflist({ id = info.id, items = 1 }).items
  end
  return vim.fn.getloclist(info.winid, { id = info.id, items = 1 }).items
end

local function item_path(item)
  if item.bufnr and item.bufnr > 0 then
    local name = vim.api.nvim_buf_get_name(item.bufnr)
    if name ~= '' then
      return vim.fn.fnamemodify(name, ':p:.')
    end
  end

  if item.filename and item.filename ~= '' then
    return vim.fn.fnamemodify(item.filename, ':p:.')
  end

  return ''
end

local function format_item_line(item)
  local path = item_path(item)
  local pos = ''

  if item.lnum and item.lnum > 0 then
    pos = ':' .. item.lnum
    if item.col and item.col > 0 then
      pos = pos .. ':' .. item.col
    end
  end

  local text = (item.text or ''):gsub('\r$', '')

  if path ~= '' then
    return string.format('%s%s | %s', path, pos, text)
  end

  return text
end

function M.quickfixtextfunc(info)
  local items = list_items(info)
  local lines = {}

  for idx = info.start_idx, info.end_idx do
    table.insert(lines, format_item_line(items[idx]))
  end

  return lines
end

local function current_qf_state()
  local qf = vim.fn.getqflist({ id = 0, title = 1, items = 1, idx = 1, qfbufnr = 1 })
  qf.items = qf.items or {}
  qf.title = qf.title or 'Quickfix'
  qf.rendered = {}

  for _, item in ipairs(qf.items) do
    table.insert(qf.rendered, format_item_line(item))
  end

  local parts = { qf.title }
  vim.list_extend(parts, qf.rendered)
  qf.hash = vim.fn.sha256(table.concat(parts, '\n'))

  return qf
end

local function explanation_marker(entry)
  if not entry then
    return '[AI?]', 'Comment'
  end

  if entry.status == 'pending' then
    return '[AI...]', 'QfExplainMarkerPending'
  end

  if entry.status == 'ready' then
    return '[AI]', 'QfExplainMarkerReady'
  end

  if entry.status == 'error' then
    return '[AI!]', 'QfExplainMarkerError'
  end

  return '[AI?]', 'Comment'
end

local function close_explain_sidebar()
  if qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid) then
    vim.api.nvim_win_close(qf_ai_state.winid, true)
  end
  qf_ai_state.winid = nil
end

local function parse_file_target(text)
  local token = (text or ''):gsub('^[`%[(<"\']+', ''):gsub('[`%])>,;"\']+$', '')
  local path, lnum, col = token:match('^(.-):(%d+):(%d+)$')

  if not path then
    path, lnum = token:match('^(.-):(%d+)$')
  end

  if not path or path == '' then
    return nil
  end

  local found = vim.fn.findfile(path, vim.o.path)
  local resolved = found ~= '' and found or path
  if vim.fn.filereadable(resolved) == 0 then
    return nil
  end

  return {
    path = resolved,
    lnum = tonumber(lnum),
    col = tonumber(col),
  }
end

local function find_non_sidebar_window()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= qf_ai_state.winid and vim.api.nvim_win_is_valid(win) then
      local cfg = vim.api.nvim_win_get_config(win)
      if cfg.relative == '' and vim.api.nvim_win_get_buf(win) ~= qf_ai_state.bufnr then
        return win
      end
    end
  end

  return nil
end

local function ensure_target_window()
  local target = find_non_sidebar_window()
  if target then
    return target
  end

  if not (qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid)) then
    return vim.api.nvim_get_current_win()
  end

  vim.api.nvim_set_current_win(qf_ai_state.winid)
  vim.cmd('leftabove vsplit')
  local new_win = vim.api.nvim_get_current_win()
  if qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid) then
    vim.api.nvim_win_set_width(qf_ai_state.winid, qf_ai_sidebar_width)
  end
  return new_win
end

local function open_target_from_sidebar()
  local target = parse_file_target(vim.api.nvim_get_current_line())
  if not target then
    vim.notify('No file target found on this line.', vim.log.levels.WARN)
    return
  end

  local win = ensure_target_window()
  vim.api.nvim_set_current_win(win)
  vim.cmd('edit ' .. vim.fn.fnameescape(target.path))

  if target.lnum then
    vim.api.nvim_win_set_cursor(win, {
      target.lnum,
      math.max((target.col or 1) - 1, 0),
    })
  end
end

local function ensure_explain_buf()
  if qf_ai_state.bufnr and vim.api.nvim_buf_is_valid(qf_ai_state.bufnr) then
    return qf_ai_state.bufnr
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].bufhidden = 'hide'
  vim.bo[bufnr].buftype = 'nofile'
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].filetype = 'markdown'
  qf_ai_state.bufnr = bufnr

  vim.keymap.set('n', 'q', function()
    close_explain_sidebar()
  end, { buffer = bufnr, silent = true })
  vim.keymap.set('n', '<CR>', open_target_from_sidebar, { buffer = bufnr, silent = true })

  return bufnr
end

local function render_explain_buf(hash)
  local bufnr = ensure_explain_buf()
  local entry = qf_ai_state.cache[hash]
  local lines = { '', '' }

  if not entry then
    table.insert(lines, 'No cached explanation for this quickfix list.')
  elseif entry.status == 'pending' then
    table.insert(lines, 'Asking the machine to inspect the current quickfix list...')
    table.insert(lines, '')
    table.insert(lines, 'Close with `q`. Reopening this sidebar will keep showing the same pending request.')
  elseif entry.status == 'error' then
    table.insert(lines, entry.content or 'No error output was captured.')
  else
    for _, line in ipairs(vim.split(entry.content or '', '\n', { plain = true })) do
      table.insert(lines, line)
    end
  end

  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].modifiable = false
end

local function ensure_explain_highlights()
  local explain = vim.api.nvim_get_hl(0, { name = 'QfExplainNormal', link = false })
  if explain and explain.bg then
    return
  end

  local pmenu = vim.api.nvim_get_hl(0, { name = 'Pmenu', link = false })
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
  local float_border = vim.api.nvim_get_hl(0, { name = 'FloatBorder', link = false })
  local bg = pmenu.bg or normal.bg
  local fg = pmenu.fg or normal.fg

  vim.api.nvim_set_hl(0, 'QfExplainNormal', {
    fg = fg,
    bg = bg,
  })
  vim.api.nvim_set_hl(0, 'QfExplainEndOfBuffer', {
    fg = bg,
    bg = bg,
  })
  vim.api.nvim_set_hl(0, 'QfExplainBorderTop', {
    fg = float_border.fg or fg,
    bg = bg,
  })
  vim.api.nvim_set_hl(0, 'QfExplainBorderBlend', {
    fg = bg,
    bg = bg,
  })
end

local function apply_explain_sidebar_window(winid)
  vim.wo[winid].winhighlight = 'Normal:QfExplainNormal,NormalNC:QfExplainNormal,EndOfBuffer:QfExplainEndOfBuffer,WinSeparator:QfExplainBorderSide'
  vim.wo[winid].wrap = true
  vim.wo[winid].linebreak = true
  vim.wo[winid].cursorline = false
  vim.wo[winid].number = false
  vim.wo[winid].relativenumber = false
  vim.wo[winid].list = false
  vim.wo[winid].signcolumn = 'no'
  vim.wo[winid].foldcolumn = '0'
  vim.wo[winid].colorcolumn = ''
  vim.wo[winid].winfixwidth = true
end

local function open_explain_sidebar(hash)
  render_explain_buf(hash)
  ensure_explain_highlights()

  local bufnr = ensure_explain_buf()
  if qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid) then
    vim.api.nvim_win_set_buf(qf_ai_state.winid, bufnr)
    apply_explain_sidebar_window(qf_ai_state.winid)
    vim.api.nvim_set_current_win(qf_ai_state.winid)
    return
  end

  vim.cmd('botright vertical sbuffer ' .. bufnr)
  qf_ai_state.winid = vim.api.nvim_get_current_win()
  vim.cmd('wincmd L')
  vim.api.nvim_win_set_width(qf_ai_state.winid, qf_ai_sidebar_width)
  apply_explain_sidebar_window(qf_ai_state.winid)
end

local function refresh_qf_ai_marks(bufnr)
  bufnr = bufnr or vim.fn.getqflist({ qfbufnr = 1 }).qfbufnr
  if not bufnr or bufnr == 0 or not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, qf_ai_ns, 0, -1)

  local qf = current_qf_state()
  qf_ai_state.current_hash = qf.hash
  local entry = qf_ai_state.cache[qf.hash]
  local marker, hl = explanation_marker(entry)

  for idx, item in ipairs(qf.items) do
    if item.valid == 1 then
      vim.api.nvim_buf_set_extmark(bufnr, qf_ai_ns, idx - 1, 0, {
        virt_text = { { marker, hl } },
        virt_text_pos = 'right_align',
        priority = 20,
      })
    end
  end
end

local function explain_command()
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    return { 'opencode', 'run' }
  end

  return {
    'codex',
    'exec',
    '--skip-git-repo-check',
    '--sandbox',
    'read-only',
    '--color',
    'never',
    '-C',
    vim.fn.getcwd(),
  }
end

local function build_explain_prompt(qf)
  local lines = {
    'You are helping with build or compiler failures from a Neovim quickfix list.',
    'Explain the likely root cause and suggest a concrete fix.',
    'Keep the answer concise and practical.',
    'Format the answer with short paragraphs.',
    'Do not use Markdown links or file:// URLs.',
    'When mentioning files, use plain relative paths like `src/main.c:14`.',
    'Do not use ``` for code snippets.',
    'When mentionning code use 4 spaces indentation.',
    'Do not make follow-up suggestion in the end, this conversation ends immediatly after your reply.',
    '',
    'Quickfix title:',
    qf.title,
    '',
    'Quickfix entries:',
  }

  for _, line in ipairs(qf.rendered) do
    table.insert(lines, '- ' .. line)
  end

  return table.concat(lines, '\n')
end

local function format_explain_output(text)
  text = (text or ''):gsub('\r', '')
  local input_lines = vim.split(text, '\n', { plain = true })
  local output_lines = {}

  for idx, line in ipairs(input_lines) do
    table.insert(output_lines, line)
    if idx < #input_lines then
      table.insert(output_lines, '')
    end
  end

  return table.concat(output_lines, '\n')
end

local function start_explain_job(qf, hash)
  local prompt = build_explain_prompt(qf)
  local entry = {
    status = 'pending',
    content = '',
    qfbufnr = qf.qfbufnr,
  }

  qf_ai_state.cache[hash] = entry
  qf_ai_state.prompt_hash = hash
  refresh_qf_ai_marks(qf.qfbufnr)
  open_explain_sidebar(hash)

  local stdout = {}
  local stderr = {}
  local job = vim.fn.jobstart(explain_command(), {
    stdin = 'pipe',
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line ~= '' then
          table.insert(stdout, line)
        end
      end
    end,
    on_stderr = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line ~= '' then
          table.insert(stderr, line)
        end
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        local combined = table.concat(stdout, '\n')
        local err_text = table.concat(stderr, '\n')

        if code == 0 and combined ~= '' then
          entry.status = 'ready'
          entry.content = format_explain_output(combined)
        else
          entry.status = 'error'
          entry.content = format_explain_output(err_text ~= '' and err_text or combined)
          if entry.content == '' then
            entry.content = 'The explainer command exited without producing output.'
          end
        end

        refresh_qf_ai_marks(entry.qfbufnr)
        if qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid) then
          render_explain_buf(hash)
        end
      end)
    end,
  })

  if job <= 0 then
    entry.status = 'error'
    entry.content = 'Failed to start the explainer command.'
    refresh_qf_ai_marks(entry.qfbufnr)
    render_explain_buf(hash)
    return
  end

  vim.fn.chansend(job, prompt)
  vim.fn.chanclose(job, 'stdin')
end

function M.explain_quickfix(opts)
  opts = opts or {}
  local qf = current_qf_state()

  if #qf.items == 0 then
    vim.notify('Quickfix is empty. Nothing for Power to explain.', vim.log.levels.WARN)
    return
  end

  qf_ai_state.current_hash = qf.hash
  local cached = qf_ai_state.cache[qf.hash]

  if opts.force then
    qf_ai_state.cache[qf.hash] = nil
    cached = nil
  end

  if cached then
    open_explain_sidebar(qf.hash)
    refresh_qf_ai_marks(qf.qfbufnr)
    return
  end

  start_explain_job(qf, qf.hash)
end

function M.toggle_explain_float()
  local qf = current_qf_state()
  qf_ai_state.current_hash = qf.hash

  if qf_ai_state.winid and vim.api.nvim_win_is_valid(qf_ai_state.winid) then
    close_explain_sidebar()
    return
  end

  if qf_ai_state.cache[qf.hash] then
    open_explain_sidebar(qf.hash)
    refresh_qf_ai_marks(qf.qfbufnr)
    return
  end

  M.explain_quickfix()
end

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
  vim.cmd(qf_height .. 'copen')
  vim.cmd('wincmd w')

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
  vim.o.quickfixtextfunc = "v:lua.require'core.quickfix'.quickfixtextfunc"

  local function update_qf_cursorline(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= 'qf' then
      return
    end

    vim.api.nvim_buf_clear_namespace(bufnr, qf_cursor_ns, 0, -1)

    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_extmark(bufnr, qf_cursor_ns, line, 0, {
      line_hl_group = 'QFCursorLine',
      priority = 10,
    })
  end

  local function clear_qf_cursorline(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= 'qf' then
      return
    end

    vim.api.nvim_buf_clear_namespace(bufnr, qf_cursor_ns, 0, -1)
  end

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
        tostring(vim.fn.line('.')),
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

  vim.api.nvim_create_user_command('QfExplain', function(opts)
    M.explain_quickfix({ force = opts.bang })
  end, {
    bang = true,
  })

  vim.api.nvim_create_user_command('QfExplainToggle', function()
    M.toggle_explain_float()
  end, {})

  local qf = vim.api.nvim_create_augroup('VINZ_quickfix', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = qf,
    pattern = 'qf',
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.list = false
      vim.opt_local.cursorline = false
      vim.opt_local.fillchars = 'eob: '
      vim.wo.winhighlight = 'Normal:QuickFixBackground,EndOfBuffer:QFEndOfBuffer'
      vim.keymap.set('n', 'ga', function()
        M.toggle_explain_float()
      end, { buffer = 0, silent = true, desc = 'Toggle quickfix AI explanation' })
      update_qf_cursorline(vim.api.nvim_get_current_buf())
      refresh_qf_ai_marks(vim.api.nvim_get_current_buf())
    end,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufWinEnter', 'WinEnter' }, {
    group = qf,
    callback = function(args)
      update_qf_cursorline(args.buf)
      refresh_qf_ai_marks(args.buf)
    end,
  })

  vim.api.nvim_create_autocmd('WinLeave', {
    group = qf,
    callback = function(args)
      clear_qf_cursorline(args.buf)
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
