local status, column = pcall(require, 'virt-column')
if (not status) then return end

column.setup({
  char = "┊",
  virtcolumn = "80"
})

