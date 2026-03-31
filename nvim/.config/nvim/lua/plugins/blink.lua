local ok, blink = pcall(require, 'blink.cmp')
if not ok then
  return
end

blink.setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'insert_next', 'fallback' },
    ['<S-Tab>'] = { 'insert_prev', 'fallback' },
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
        auto_insert = true,
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      path = {
        opts = {
          trailing_slash = false,
          label_trailing_slash = false,
        },
      },
      cmdline = {
        min_keyword_length = 0,
      },
    },
  },
  cmdline = {
    enabled = false,
    keymap = {
      preset = 'cmdline',
      ['<Tab>'] = { 'insert_next', 'fallback' },
      ['<S-Tab>'] = { 'insert_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    sources = { 'buffer', 'cmdline' },
  },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
  },
})
