local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup()

vim.keymap.set('n', '<leader>b', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>NvimTreeFindFile<cr>')
