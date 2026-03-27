local ok_alpha, alpha = pcall(require, 'alpha')
if not ok_alpha then
  return
end

local ok_dashboard, dashboard = pcall(require, 'alpha.themes.dashboard')
if not ok_dashboard then
  return
end

dashboard.section.header.val = { '', '', '', '' }
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('f', '󰱼  Find file', ':lua require("fzf-lua").files()<CR>'),
  dashboard.button('r', '  Recent files', ':lua require("fzf-lua").oldfiles()<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

dashboard.section.footer.val = ''
alpha.setup(dashboard.opts)
