local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local function diagnostic_count(severity, icon)
  local diagnostics = vim.diagnostic.get(0, { severity = severity })
  if #diagnostics == 0 then
    return ''
  end
  return string.format('%s %d', icon, #diagnostics)
end

local function lsp_error_count()
  return diagnostic_count(vim.diagnostic.severity.ERROR, '󰈸')
end

local function lsp_warn_count()
  return diagnostic_count(vim.diagnostic.severity.WARN, '')
end

local function lsp_hint_count()
  return diagnostic_count(vim.diagnostic.severity.HINT, '')
end

local function lsp_info_count()
  return diagnostic_count(vim.diagnostic.severity.INFO, '')
end

local function paste_status()
  return vim.o.paste and 'PASTE' or ''
end

lualine.setup({
  options = {
    theme = 'monotone',
    component_separators = { left = '┋', right = '│' },
    section_separators = { left = '║', right = '' },
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
        color = { fg = '#111111', bg = '#d7d7d7' },
      },
    },
    lualine_b = {
      {
        lsp_error_count,
        color = { fg = '#ff9999', bg = '#221111' },
      },
      {
        lsp_warn_count,
        color = { fg = '#eeee99', bg = '#222211' },
      },
      {
        lsp_hint_count,
        color = { fg = '#c0c0ff', bg = '#111122' },
      },
      {
        lsp_info_count,
        color = { fg = '#99ffff', bg = '#112222' },
      },
      {
        'readonly',
      },
      paste_status,
      {
        'modified',
        symbols = { modified = '+', readonly = '-', unnamed = '' },
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'location', 'progress' },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'filename',
        path = 1,
        color = { fg = '#9e9e9e', bg = '#333333' },
      },
      {
        'modified',
        symbols = { modified = '+', readonly = '-', unnamed = '' },
        color = { fg = '#9e9e9e', bg = '#333333' },
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
