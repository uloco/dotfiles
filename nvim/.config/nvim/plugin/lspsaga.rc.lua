local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.init_lsp_saga {
  border_style = "rounded",
  saga_winblend = 15,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 50,
  code_action_icon = "",
  code_action_lightbulb = {
    sign = false,
    virtual_text = true,
  },
  finder_action_keys = {
    open = "<CR>",
    vsplit = "v",
    split = "s",
    quit = "<esc>",
  },
  code_action_keys = {
    quit = "<esc>",
    exec = "<CR>",
  },
  definition_action_keys = {
    edit = '<CRY',
    vsplit = '<C-c>v',
    split = '<C-c>i',
    tabe = '<C-c>t',
    quit = "<esc>",
  },
  scroll_in_preview = {
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
  rename_action_quit = "<esc>",

  server_filetype_map = {},
}


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>je', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('v', '<Leader>ca', '<Cmd>Lspsaga range_code_action<CR>', opts)
