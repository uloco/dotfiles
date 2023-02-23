local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup({
  ui = {
    winblend = 15,
    border = "rounded",
    code_action = "",
  },
  preview = {
    lines_above = 10,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
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
    quit = 'q',
    close = '<esc>',
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = '<esc>',
      exec = '<cr>',
    },
  },
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = false,
    sign_priority = 40,
    virtual_text = true,
  },
  rename = {
    quit = '<esc>',
  },
  symbol_in_winbar = {
    enable = true,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 1,
    respect_root = false,
    color_mode = true,
  },
})

--   diagnostic_header = { " ", " ", " ", "ﴞ " },

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ke', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', '<leader>je', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('v', '<Leader>ca', '<Cmd>Lspsaga range_code_action<CR>', opts)
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)
