if vim.fn.has('unix') == 1 then
  vim.opt.errorformat:append({
    'FAIL %m (%f:%l)',
    'SKIP %m (%f:%l)',
    'PASS %m (%f:%l)',
  })
else
  vim.opt.errorformat = {
    '%f(%l\\,%c): %m',
    '%f(%l) : %m',
    '%f(%l,%c): %m',
    '%f(%l): %m',
    '%t %m - %f',
  }
end
