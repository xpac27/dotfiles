local opt = vim.opt

opt.exrc = true
opt.autoread = true
opt.backspace = { 'indent', 'eol', 'start' }
opt.complete:remove('i')
opt.completeopt = { 'longest', 'menuone' }
opt.cursorline = true
opt.encoding = 'UTF-8'
opt.equalalways = true
opt.expandtab = true
opt.formatoptions = 'vtr'
opt.fileformats = { 'unix', 'dos', 'mac' }
opt.fillchars = { vert = '┃' }
opt.gdefault = true
opt.hidden = true
opt.history = 1000
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 2
opt.lazyredraw = true
opt.mouse = 'a'
opt.mousehide = true
opt.errorbells = false
opt.list = true
opt.modeline = false
opt.ruler = false
opt.showmode = false
opt.swapfile = false
opt.visualbell = false
opt.wrap = false
opt.number = true
opt.path = { '.', '', '**', '/usr/local/include', '/usr/include' }
opt.pumheight = 15
opt.relativenumber = true
opt.scrolljump = 5
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append('at')
opt.showmatch = true
opt.showtabline = 1
opt.sidescrolloff = 5
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 4
opt.spelllang = { 'en_us' }
opt.splitbelow = true
opt.splitright = true
opt.tabpagemax = 999
opt.tabstop = 4
opt.termguicolors = true
opt.tags = { './tags', '.tags', 'tags' }
opt.textwidth = 99999
opt.timeoutlen = 300
opt.undodir = vim.fn.expand('~/.cache/nvim/undo')
opt.backupdir = vim.fn.expand('~/.cache/nvim/backup')
opt.backupskip:append('*.gpg')
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 1000
opt.updatetime = 300
opt.wildignore = { '*.o', '*.d', '*.a', '*.so', '*.pyc', '*.swp', '*.orig' }
opt.wildmenu = true
opt.wildmode = { 'longest', 'list' }
opt.fixendofline = false
opt.backup = true
opt.writebackup = true
opt.clipboard = { 'unnamed', 'unnamedplus' }

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  opt.listchars = { lead = ':', trail = '·', tab = '  ' }
else
  opt.listchars = { tab = '»-', trail = '·' }
end

if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --vimgrep'
  vim.o.grepformat = '%f:%l:%c:%m'
end

opt.background = (vim.g.theme == 'light') and 'light' or 'dark'

if vim.wo.diff then
  opt.diffopt:append({ 'algorithm:patience', 'indent-heuristic' })
end
