local status, which = pcall(require, 'which-key')
if (not status) then return end

which.setup({
  prefix = "<leader>"
})
