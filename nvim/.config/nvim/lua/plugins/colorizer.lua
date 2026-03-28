local ok, colorizer = pcall(require, 'colorizer')
if not ok then
  return
end

colorizer.setup({
  filetypes = { '*' },
  user_default_options = {
    mode = 'background',
    names = false,
    css = true,
    css_fn = true,
    tailwind = true,
    sass = { enable = true, parsers = { css = true } },
    xterm = true,
  },
})
