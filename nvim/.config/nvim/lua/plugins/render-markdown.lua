local ok, render_markdown = pcall(require, 'render-markdown')
if not ok then
  return
end

render_markdown.setup({
  heading = {
    sign = false,
    position = 'inline',
    icons = { '🔶 ', '🔸 ', '◆ ', '◇ ', '• ', '◦ ' },
  },
  bullet = {
    icons = { '◆', '▸', '•', '◦' },
  },
  checkbox = {
    unchecked = {
      icon = '☐ ',
    },
    checked = {
      icon = '☑ ',
    },
    custom = {
      todo = { raw = '[-]', rendered = '🕯️ ', highlight = 'RenderMarkdownTodo' },
    },
  },
  quote = {
    icon = '▌',
  },
  pipe_table = {
    preset = 'round',
  },
})
