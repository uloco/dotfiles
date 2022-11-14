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
  },
  auto_scroll = false
})

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "t" }, "˝", "<cmd>ToggleTermToggleAll<cr>", opts) -- Alt-Gr + shift + t

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
  cmd = [[
    THEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)
    XDG_CONFIG_DIR=${HOME}/.config
    CONFIG_BASE=${XDG_CONFIG_DIR}/lazygit/config.yml
    CONFIG_THEME=${XDG_CONFIG_DIR}/lazygit/config-${THEME}.yml
    lazygit --use-config-file=${CONFIG_BASE},${CONFIG_THEME}
    ]],
  hidden = true,
  direction = 'float',
})

local floating = Terminal:new({ cmd = "zsh", hidden = true, direction = 'float' })

vim.keymap.set({ "n", "t" }, "©", function() lazygit:toggle() vim.cmd('checktime') end, opts)
vim.keymap.set({ "n", "t" }, "ª", function() floating:toggle() end, opts) -- Alt-Gr + h

local cmd = vim.api.nvim_create_user_command
cmd("LazygitOpen", function() lazygit:open() end, {})
cmd("LazygitToggle", function() lazygit:toggle() end, {})
cmd("LazygitClose", function() lazygit:close() end, {})
