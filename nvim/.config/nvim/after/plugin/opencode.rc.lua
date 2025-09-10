-- opencode.nvim configuration and keymaps
-- https://github.com/NickvanDyke/opencode.nvim

-- snacks.nvim (dependency for prompt input and embedded terminal)
local snacks_ok, snacks = pcall(require, 'snacks')
if snacks_ok then
  snacks.setup({ input = { enabled = true } })
end

vim.g.opencode_opts = {}
vim.opt.autoread = true

local ok, opencode = pcall(require, 'opencode')
if not ok then
  return
end

-- Keymaps (normal and visual mode)
vim.keymap.set('n', '<leader>ot', function() opencode.toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set('n', '<leader>oA', function() opencode.ask() end, { desc = 'Ask opencode' })
vim.keymap.set('n', '<leader>oa', function() opencode.ask('@cursor: ') end, { desc = 'Ask opencode about this' })
vim.keymap.set('v', '<leader>oa', function() opencode.ask('@selection: ') end, { desc = 'Ask opencode about selection' })
vim.keymap.set('n', '<leader>on', function() opencode.command('session_new') end, { desc = 'New opencode session' })
vim.keymap.set('n', '<leader>oy', function() opencode.command('messages_copy') end, { desc = 'Copy last opencode response' })
vim.keymap.set('n', '<S-C-u>',    function() opencode.command('messages_half_page_up') end, { desc = 'Messages half page up' })
vim.keymap.set('n', '<S-C-d>',    function() opencode.command('messages_half_page_down') end, { desc = 'Messages half page down' })
vim.keymap.set({ 'n', 'v' }, '<leader>os', function() opencode.select() end, { desc = 'Select opencode prompt' })
-- Example: keymap for custom prompt
vim.keymap.set('n', '<leader>oe', function() opencode.prompt('Explain @cursor and its context') end, { desc = 'Explain this code' })
