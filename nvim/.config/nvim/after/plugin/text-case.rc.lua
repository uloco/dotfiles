local status, textcase = pcall(require, 'textcase')
if (not status) then return end

textcase.setup {}

-- show text conversion in telescope
require('telescope').load_extension('textcase')
vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
