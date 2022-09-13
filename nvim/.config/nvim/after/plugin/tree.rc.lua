-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set('n', '<Leader>b', '<cmd>NvimTreeToggle<cr>')
