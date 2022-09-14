local status, column = pcall(require, 'virt-column')
if (not status) then return end

vim.opt.colorcolumn = "80"

column.setup({
  char = "┊"
})
