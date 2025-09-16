local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup({
  ui = {
    winblend = 15,
    border = "rounded",
    code_action = "󰌵",
  },
  beacon = {
    enable = false,
    frequency = 20,
  },
  preview = {
    lines_above = 10,
    lines_below = 10,
  },
  request_timeout = 2000,
  finder = {
    edit = { 'e', '<cr>' },
    vsplit = '<C-v>',
    split = '<C-s>',
    tabe = '<C-t>',
    quit = { 'q', '<esc>' },
  },
  definition = {
    edit = '<C-c>e',
    vsplit = '<C-c>v',
    split = '<C-c>s',
    tabe = '<C-c>t',
    quit = '<esc>',
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = '<esc>',
      exec = '<cr>',
    },
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    sign_priority = 40,
    virtual_text = true,
  },
  rename = {
    keys = {
      quit = '<esc>',
    }
  },
  symbol_in_winbar = {
    enable = false,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 0,
    respect_root = false,
    color_mode = true,
  },
})

--   diagnostic_header = { " ", " ", " ", "ﴞ " },

-- fix line diagnostic not showing
vim.diagnostic.config({ severity_sort = true })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ke', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', '<leader>je', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', '<leader>gD', '<Cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', '<leader>gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<leader>gP', '<Cmd>Lspsaga peek_type_definition<CR>', opts)
vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('v', '<Leader>ca', '<Cmd>Lspsaga range_code_action<CR>', opts)
