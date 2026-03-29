if vim.fn.has('nvim-0.11') == 0 then
  return
end

-- Diagnostic symbols are behavior/UI choices, not theme colors.
local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = '󰈸',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.HINT] = '',
}

-- Severity names are used to derive the custom range highlight groups:
-- DiagnosticRangeError, DiagnosticRangeWarn, DiagnosticRangeInfo, DiagnosticRangeHint.
-- The actual colors for those groups live in colors/monotone.lua.
local diagnostic_severity_names = {
  [vim.diagnostic.severity.ERROR] = 'Error',
  [vim.diagnostic.severity.WARN] = 'Warn',
  [vim.diagnostic.severity.INFO] = 'Info',
  [vim.diagnostic.severity.HINT] = 'Hint',
}

local diagnostic_range_ns = vim.api.nvim_create_namespace('vinz_diagnostic_ranges')

local function diagnostic_highlight(severity)
  local name = diagnostic_severity_names[severity]
  return name and ('DiagnosticRange' .. name) or nil
end

-- Keep the builtin diagnostic features simple here and let the theme define
-- the colors through the standard Diagnostic* highlight groups.
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

-- Neovim underlines diagnostics by default, but it does not tint the source
-- code range in the same way the old Vim setup did. This custom handler adds a
-- stronger extmark highlight over the diagnostic span using theme-owned
-- DiagnosticRange* groups from the colorscheme.
vim.diagnostic.handlers['vinz/range_highlight'] = {
  show = function(_, bufnr, diagnostics)
    vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_range_ns, 0, -1)

    for _, diagnostic in ipairs(diagnostics) do
      local hl_group = diagnostic_highlight(diagnostic.severity)
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
          hl_mode = 'replace',
          priority = 250,
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
