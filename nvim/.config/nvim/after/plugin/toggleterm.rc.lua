local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

toggleterm.setup({
  hide_numbers = false,
  open_mapping = '<A-ß>',
  insert_mappings = true,
  terminal_mappings = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 10,
  },
  persist_size = false,
  winbar = {
    enable = true
  }
})

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "source ~/.zshrc; lazygit",  hidden = true })

function lazygit_toggle()
  lazygit:toggle()
  print('yea')
end

vim.keymap.set({"n", "t"}, "©", function () lazygit_toggle() end, { noremap = true, silent = true })
