local status, trouble = pcall(require, 'trouble')
if (not status) then return end

trouble.setup()

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
vim.keymap.set('n', '<leader>xW', '<cmd>Trouble workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xD', '<cmd>Trouble document_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp_references<cr>', opts)
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble lsp_definitions<cr>', opts)
vim.keymap.set('n', '<leader>xt', '<cmd>Trouble lsp_type_definitions<cr>', opts)
vim.keymap.set('n', '<leader>xi', '<cmd>Trouble lsp_implementations<cr>', opts)
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', opts)
