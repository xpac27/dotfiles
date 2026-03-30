local ok, tabby = pcall(require, 'tabby')
if not ok then
  return
end

vim.o.showtabline = 2

local theme = {
  fill = 'TabLineFill',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabbyWin',
  current_win = 'TabbyWinSel',
}

tabby.setup({
  line = function(line)
    return {
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          ' ',
          tab.name(),
          ' ',
          line.sep('║', hl, theme.fill),
          hl = hl,
        }
      end),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        local hl = win.is_current() and theme.current_win or theme.win
        return {
          ' ',
          win.buf_name(),
          ' ',
          hl = hl,
        }
      end),
      line.spacer(),
      hl = theme.fill,
    }
  end,
  option = {
    tab_name = {
      name_fallback = function(tabid)
        local wins = vim.api.nvim_tabpage_list_wins(tabid)
        local win = wins[1]
        if not win then
          return tostring(tabid)
        end

        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if name == '' then
          return tostring(tabid)
        end

        return vim.fn.fnamemodify(name, ':t')
      end,
    },
    buf_name = {
      mode = 'unique',
    },
  },
})
