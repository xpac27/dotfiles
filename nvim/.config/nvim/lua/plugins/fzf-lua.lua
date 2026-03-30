local ok, fzf = pcall(require, 'fzf-lua')
if not ok then
  return
end

fzf.setup({
  winopts = {
    preview = {
      hidden = true,
    },
  },
  hls = {
    normal = 'FzfLuaNormal',
    border = 'FzfLuaBorder',
    title = 'FzfLuaTitle',
    cursorline = 'FzfLuaCursorLine',
    cursorlinenr = 'FzfLuaCursorLineNr',
    search = 'FzfLuaSearch',
    preview_normal = 'FzfLuaPreviewNormal',
    preview_border = 'FzfLuaPreviewBorder',
    preview_title = 'FzfLuaPreviewTitle',
    scrollborder_e = 'FzfLuaScrollBorderEmpty',
    scrollborder_f = 'FzfLuaScrollBorderFull',
    scrollfloat_e = 'FzfLuaScrollFloatEmpty',
    scrollfloat_f = 'FzfLuaScrollFloatFull',
    header_bind = 'FzfLuaHeaderBind',
    header_text = 'FzfLuaHeaderText',
    path_linenr = 'FzfLuaPathLineNr',
    path_colnr = 'FzfLuaPathColNr',
    dir_icon = 'FzfLuaDirIcon',
    dir_part = 'FzfLuaDirPart',
    file_part = 'FzfLuaFilePart',
    live_prompt = 'FzfLuaLivePrompt',
  },
  fzf_colors = true,
  files = {
    cmd = [[rg --files --hidden --follow]],
  },
  grep = {
    rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --vimgrep]],
  },
  keymap = {
    builtin = {
      ['<C-a>'] = 'toggle-all',
    },
  },
})

vim.keymap.set('n', '<leader>f', fzf.files, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', fzf.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>l', fzf.blines, { desc = 'Buffer lines' })
vim.keymap.set('n', '<leader>g', function()
  fzf.live_grep({ no_esc = true, multiprocess = true })
end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>G', function()
  fzf.grep({ search = vim.fn.expand('<cword>'), fixed_strings = true })
end, { desc = 'Fixed grep word' })

vim.api.nvim_create_user_command('Find', function(opts)
  fzf.grep({ search = opts.args, fixed_strings = true })
end, { nargs = '*' })

vim.api.nvim_create_user_command('FindFiles', function(opts)
  fzf.grep({ search = opts.args, fixed_strings = true, rg_opts = '--max-count=1 --vimgrep' })
end, { nargs = '*' })

vim.api.nvim_create_user_command('Files', function()
  fzf.files()
end, {})

vim.api.nvim_create_user_command('BLines', function()
  fzf.blines()
end, {})
