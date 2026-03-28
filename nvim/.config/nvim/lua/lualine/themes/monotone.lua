local colors = {
  bg0 = '#111111',
  bg1 = '#191919',
  bg2 = '#222222',
  bg3 = '#4e4e4e',
  fg0 = '#d7d7d7',
  fg1 = '#bcbcbc',
  fg2 = '#9e9e9e',
  normal = '#d7d7d7',
  insert = '#a8d7af',
  visual = '#ffffff',
  replace = '#ff9999',
  warn = '#eeee99',
  warn_bg = '#222211',
  err = '#ff9999',
  err_bg = '#221111',
  info = '#99ffff',
  info_bg = '#112222',
  hint = '#c0c0ff',
  hint_bg = '#111122',
}

return {
  normal = {
    a = { fg = colors.bg1, bg = colors.normal },
    b = { fg = colors.fg2, bg = colors.bg0 },
    c = { fg = colors.fg2, bg = colors.bg1 },
    x = { fg = colors.fg1, bg = colors.bg3 },
    y = { fg = colors.fg2, bg = colors.bg2 },
    z = { fg = colors.fg2, bg = colors.bg1 },
    warning = { fg = colors.warn, bg = colors.warn_bg },
    error = { fg = colors.err, bg = colors.err_bg },
  },
  insert = {
    a = { fg = colors.bg1, bg = colors.insert },
    b = { fg = colors.fg2, bg = colors.bg0 },
    c = { fg = colors.fg2, bg = colors.bg1 },
  },
  visual = {
    a = { fg = colors.bg1, bg = colors.visual },
    b = { fg = colors.fg2, bg = colors.bg0 },
    c = { fg = colors.fg2, bg = colors.bg1 },
  },
  replace = {
    a = { fg = colors.bg1, bg = colors.replace },
    b = { fg = colors.fg2, bg = colors.bg0 },
    c = { fg = colors.fg2, bg = colors.bg1 },
  },
  command = {
    a = { fg = colors.bg1, bg = colors.normal },
    b = { fg = colors.fg2, bg = colors.bg0 },
    c = { fg = colors.fg2, bg = colors.bg1 },
  },
  inactive = {
    a = { fg = colors.fg2, bg = colors.bg3 },
    b = { fg = colors.bg3, bg = colors.bg0 },
    c = { fg = colors.bg3, bg = colors.bg1 },
  },
}
