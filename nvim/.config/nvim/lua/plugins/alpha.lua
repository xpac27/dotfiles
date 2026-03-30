local ok_alpha, alpha = pcall(require, 'alpha')
if not ok_alpha then
  return
end

local ok_startify, startify = pcall(require, 'alpha.themes.startify')
if not ok_startify then
  return
end

startify.section.header.val = {}
alpha.setup(startify.config)
