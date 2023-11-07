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
    width = function()
      local columns = vim.opt.columns._value
      if columns > 400 then
        return columns - 150
      elseif columns > 200 then
        return columns - 100
      else
        return columns - 20
      end
    end,
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
  -- hidden terms need high ids otherwise clash with count toggle
  id = 100,
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

local floating = Terminal:new({
  id = 101,
  cmd = "zsh",
  hidden = true,
  direction = 'float'
})

vim.keymap.set({ "n", "t" }, "©", function()
  lazygit:toggle()
  vim.cmd('checktime')
end, opts)
vim.keymap.set({ "n", "t" }, "ª", function() floating:toggle() end, opts) -- Alt-Gr + h

local cmd = vim.api.nvim_create_user_command
cmd("LazygitOpen", function() lazygit:open() end, {})
cmd("LazygitToggle", function() lazygit:toggle() end, {})
cmd("LazygitClose", function() lazygit:close() end, {})


-- Auto insert mode when entering terminal
local augroup_term_insert = vim.api.nvim_create_augroup("Term-Insert", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
  group = augroup_term_insert,
  pattern = 'term://*',
  command = 'startinsert'
})

-- Auto insert mode when entering terminal with mouse click
local augroup_term_insert_mouse = vim.api.nvim_create_augroup("Term-Insert-Mouse", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup_term_insert_mouse,
  pattern = '*',
  command = 'nnoremap <buffer><LeftRelease> <LeftRelease>i'
})
