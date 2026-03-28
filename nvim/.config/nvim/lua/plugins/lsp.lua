if vim.fn.has('nvim-0.11') == 0 then
  return
end

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = '󰈸',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.HINT] = '',
}

local diagnostic_range_highlights = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
}

local diagnostic_range_ns = vim.api.nvim_create_namespace('vinz_diagnostic_ranges')

vim.diagnostic.config({
  underline = true,
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

vim.diagnostic.handlers['vinz/range_highlight'] = {
  show = function(_, bufnr, diagnostics)
    vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_range_ns, 0, -1)

    for _, diagnostic in ipairs(diagnostics) do
      local hl_group = diagnostic_range_highlights[diagnostic.severity]
      if hl_group then
        local end_lnum = diagnostic.end_lnum or diagnostic.lnum
        local end_col = diagnostic.end_col or (diagnostic.col + 1)

        if end_lnum == diagnostic.lnum and end_col <= diagnostic.col then
          end_col = diagnostic.col + 1
        end

        vim.api.nvim_buf_set_extmark(bufnr, diagnostic_range_ns, diagnostic.lnum, diagnostic.col, {
          end_row = end_lnum,
          end_col = end_col,
          hl_group = hl_group,
          hl_mode = 'combine',
          priority = 150,
          strict = false,
        })
      end
    end
  end,
  hide = function(_, bufnr)
    vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_range_ns, 0, -1)
  end,
}

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
