local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup({
  view = {
    number = true,
    relativenumber = true
  }
})

vim.keymap.set('n', '<leader>b', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>NvimTreeFindFile<cr>')
