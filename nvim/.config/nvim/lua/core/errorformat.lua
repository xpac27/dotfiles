if vim.fn.has('unix') == 1 then
  vim.cmd([[set errorformat+=FAIL\ %m\ (%f:%l)]])
  vim.cmd([[set errorformat+=SKIP\ %m\ (%f:%l)]])
  vim.cmd([[set errorformat+=PASS\ %m\ (%f:%l)]])
else
  vim.opt.errorformat = {
    '%f(%l\\,%c): %m',
    '%f(%l) : %m',
    '%f(%l,%c): %m',
    '%f(%l): %m',
    '%t %m - %f',
  }
end
