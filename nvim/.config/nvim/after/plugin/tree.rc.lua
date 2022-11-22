local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup()

vim.keymap.set('n', '<leader>b', '<cmd>NvimTreeToggle<cr>')
