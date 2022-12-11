local status, bluloco = pcall(require, 'bluloco')
if (not status) then return end

bluloco.setup({
  style = "auto",
  transparent = false,
  italics = false,
  terminal = true
})

vim.cmd('colorscheme bluloco')
