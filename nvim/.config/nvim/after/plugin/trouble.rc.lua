local status, trouble = pcall(require, 'trouble')
if (not status) then return end

trouble.setup()

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
vim.keymap.set('n', '<leader>xW', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xD', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>', opts)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle lsp_definitions<cr>', opts)
vim.keymap.set('n', '<leader>xt', '<cmd>TroubleToggle lsp_type_definitions<cr>', opts)
vim.keymap.set('n', '<leader>xi', '<cmd>TroubleToggle lsp_implementations<cr>', opts)
