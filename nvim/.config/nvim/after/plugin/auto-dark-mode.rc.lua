local auto_dark_mode = require('auto-dark-mode')

local bluloco = require("bluloco")

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    local current = vim.api.nvim_get_option('background')
    if (bluloco.config.style == "auto" and current == 'light') then
      vim.api.nvim_set_option('background', 'dark')
      vim.cmd [[colorscheme bluloco]]
    end
  end,
  set_light_mode = function()
    local current = vim.api.nvim_get_option('background')
    if (bluloco.config.style == "auto" and current == 'dark') then
      vim.api.nvim_set_option('background', 'light')
      vim.cmd [[colorscheme bluloco]]
    end
  end,
})
