local ok, blink = pcall(require, 'blink.cmp')
if not ok then
  return
end

blink.setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        end
        return cmp.show_and_insert()
      end,
      'fallback',
    },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = 'cmdline',
      ['<Tab>'] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_next()
          end
          return cmp.show_and_insert()
        end,
        'fallback',
      },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
    sources = { 'buffer', 'cmdline' },
  },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
  },
})
