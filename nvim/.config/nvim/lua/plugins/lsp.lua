if vim.fn.has('nvim-0.11') == 0 then
  return
end

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = '🔥',
  [vim.diagnostic.severity.WARN] = '🟡',
  [vim.diagnostic.severity.INFO] = '💡',
  [vim.diagnostic.severity.HINT] = '🧠',
}

vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic)
      return diagnostic_icons[diagnostic.severity] or '•'
    end,
  },
  signs = {
    text = diagnostic_icons,
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
})

local map = vim.keymap.set

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }

  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gD', vim.lsp.buf.type_definition, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map('n', 'gS', vim.lsp.buf.document_symbol, opts)
  map('n', 'gs', vim.lsp.buf.workspace_symbol, opts)
  map('n', 'ga', vim.lsp.buf.code_action, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)

  map('n', '[g', vim.diagnostic.goto_prev, opts)
  map('n', ']g', vim.diagnostic.goto_next, opts)
  map('n', '<Right>', vim.diagnostic.goto_next, opts)
  map('n', '<Left>', vim.diagnostic.goto_prev, opts)
end

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--completion-style=bundled', '--function-arg-placeholders=1', '--header-insertion-decorators' },
  on_attach = on_attach,
})
vim.lsp.enable('clangd')

if vim.fn.executable('typos-lsp') == 1 then
  vim.lsp.config('typos_lsp', {
    on_attach = on_attach,
  })
  vim.lsp.enable('typos_lsp')
end
