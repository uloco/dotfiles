local status, bluloco = pcall(require, 'bluloco')
if (not status) then return end

bluloco.setup({
  transparent = false,
  italics = false,
  style = "auto"
})

vim.cmd('colorscheme bluloco')
