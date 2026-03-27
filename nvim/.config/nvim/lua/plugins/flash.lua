local ok, flash = pcall(require, 'flash')
if not ok then
  return
end

flash.setup()
vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  flash.jump()
end, { desc = 'Flash jump' })
