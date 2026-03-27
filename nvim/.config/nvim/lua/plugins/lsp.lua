local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

vim.diagnostic.config({
  virtual_text = true,
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

lspconfig.clangd.setup({
  cmd = { 'clangd', '--completion-style=bundled', '--function-arg-placeholders=1', '--header-insertion-decorators' },
  on_attach = on_attach,
})

if vim.fn.executable('typos-lsp') == 1 then
  lspconfig.typos_lsp.setup({
    on_attach = on_attach,
  })
end
