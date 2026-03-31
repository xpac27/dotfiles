local ok_alpha, alpha = pcall(require, 'alpha')
if not ok_alpha then
  return
end

local ok_startify, startify = pcall(require, 'alpha.themes.startify')
if not ok_startify then
  return
end

local function section_title(title)
  return {
    type = 'text',
    val = title,
    opts = { hl = 'AlphaSectionTitle', shrink_margin = false },
  }
end

local function header_banner()
  local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':t'):upper()
  local text = '💀  ' .. project .. '  💀'
  local width = vim.fn.strdisplaywidth(text)
  local border = string.rep('─', math.max(width - 2, 0))

  return {
    '╭' .. border .. '╮',
    text,
    '╰' .. border .. '╯',
  }
end

local function bookmarks_section()
  local bookmarks = {
    vim.fn.expand('~/.config/nvim/init.lua'),
    vim.fn.expand('~/.vimrc'),
  }
  local buttons = {}

  for _, path in ipairs(bookmarks) do
    if vim.fn.filereadable(path) == 1 then
      local label = vim.fn.fnamemodify(path, ':~')
      buttons[#buttons + 1] = startify.file_button(path, tostring(#buttons + 1), label)
    end
  end

  if #buttons == 0 then
    return nil
  end

  return {
    type = 'group',
    val = {
      { type = 'padding', val = 1 },
      section_title('😈 Bookmarks'),
      { type = 'padding', val = 1 },
      { type = 'group', val = buttons, opts = { shrink_margin = false } },
    },
  }
end

local function sessions_section()
  local session_paths = {}
  local cwd_session = vim.fn.getcwd() .. '/Session.vim'
  local session_dir = vim.fn.stdpath('data') .. '/session'

  if vim.fn.filereadable(cwd_session) == 1 then
    session_paths[#session_paths + 1] = cwd_session
  end

  if vim.fn.isdirectory(session_dir) == 1 then
    for _, path in ipairs(vim.fn.globpath(session_dir, '*.vim', false, true)) do
      if path ~= cwd_session and vim.fn.filereadable(path) == 1 then
        session_paths[#session_paths + 1] = path
      end
      if #session_paths >= 6 then
        break
      end
    end
  end

  if #session_paths == 0 then
    return nil
  end

  local buttons = {}
  for i, path in ipairs(session_paths) do
    local label = vim.fn.fnamemodify(path, ':t:r')
    if path == cwd_session then
      label = '[cwd] ' .. label
    end
    buttons[#buttons + 1] = startify.button(
      tostring(i),
      label,
      '<cmd>silent! source ' .. vim.fn.fnameescape(path) .. ' <CR>'
    )
  end

  return {
    type = 'group',
    val = {
      { type = 'padding', val = 1 },
      section_title('🦴 Sessions'),
      { type = 'padding', val = 1 },
      { type = 'group', val = buttons, opts = { shrink_margin = false } },
    },
  }
end

startify.section.header.val = header_banner()
startify.section.top_buttons.val = {
  startify.button('e', 'New file', '<cmd>ene <CR>'),
}
startify.section.bottom_buttons.val = {
  startify.button('q', 'Quit', '<cmd>q <CR>'),
}
startify.section.mru_cwd.val[2] = section_title('👻 MRU ' .. vim.fn.getcwd())

local bookmarks = bookmarks_section()
local sessions = sessions_section()

local layout = {
  { type = 'padding', val = 1 },
  startify.section.header,
  { type = 'padding', val = 2 },
  startify.section.top_buttons,
  { type = 'padding', val = 1 },
  startify.section.mru_cwd,
  { type = 'padding', val = 1 },
  bookmarks,
  { type = 'padding', val = 1 },
  sessions,
  { type = 'padding', val = 2 },
  startify.section.bottom_buttons,
  startify.section.footer,
  { type = 'padding', val = 1 },
}

startify.config.layout = layout
alpha.setup(startify.config)
