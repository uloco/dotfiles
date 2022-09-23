local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

toggleterm.setup({
  hide_numbers = false,
  open_mapping = '†', -- Alt-Gr + t
  insert_mappings = true,
  terminal_mappings = true,
  direction = 'vertical',
  size = 100,
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
  persist_size = false,
  winbar = {
    enable = true
  }
})

vim.keymap.set({ "n", "t" }, "˝", "<cmd>ToggleTermToggleAll<cr>", { noremap = true, silent = true }) -- Alt-Gr + shift + t

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "source ~/.zshrc; lazygit", hidden = true, direction = 'float' })
local htop     = Terminal:new({ cmd = "htop", hidden = true, direction = 'float' })


vim.keymap.set({ "n", "t" }, "©", function() lazygit:toggle()  vim.cmd('checktime') end, { noremap = true, silent = true }) -- Alt-Gr + g
vim.keymap.set({ "n", "t" }, "ª", function() htop:toggle() end, { noremap = true, silent = true }) -- Alt-Gr + h

local cmd = vim.api.nvim_create_user_command
cmd("LazygitOpen", function() lazygit:open() end, {})
cmd("LazygitToggle", function() lazygit:toggle() end, {})
cmd("LazygitClose", function() lazygit:close() end, {})
