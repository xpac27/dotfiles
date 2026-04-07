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
  local ok_auto_session, auto_session = pcall(require, 'auto-session')
  local ok_lib, auto_session_lib = pcall(require, 'auto-session.lib')
  if not ok_auto_session or not ok_lib then
    return nil
  end

  local ok_root_dir, root_dir = pcall(auto_session.get_root_dir)
  if not ok_root_dir or type(root_dir) ~= 'string' or root_dir == '' then
    return nil
  end

  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
  local escaped_cwd = auto_session_lib.escape_string_for_vim(cwd)
  local sessions = {}

  local function session_belongs_to_cwd(entry)
    if entry.session_name == cwd then
      return true
    end

    if vim.fn.filereadable(entry.path) ~= 1 then
      return false
    end

    for _, line in ipairs(vim.fn.readfile(entry.path)) do
      if line:match('^cd%s+' .. escaped_cwd .. '$') or line:match('^lcd%s+' .. escaped_cwd .. '$') then
        return true
      end
    end

    return false
  end

  for _, entry in ipairs(auto_session_lib.get_session_list(root_dir)) do
    if session_belongs_to_cwd(entry) then
      sessions[#sessions + 1] = entry
    end
    if #sessions >= 6 then
      break
    end
  end

  if #sessions == 0 then
    return nil
  end

  local buttons = {}
  for i, entry in ipairs(sessions) do
    local label = entry.display_name
    if entry.session_name == cwd then
      label = '[cwd] ' .. label
    end
    buttons[#buttons + 1] = startify.button(
      tostring(i),
      label,
      '<cmd>SOpen ' .. vim.fn.fnameescape(entry.session_name) .. '<CR>'
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
  { type = 'padding', val = 2 },
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
