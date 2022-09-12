local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
  },
  numhl = true,
  current_line_blame_formatter = '     <author>, <author_time:%Y-%m-%d> - <summary>',
}


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)
vim.keymap.set('n', '<Leader>kh', ':Gitsigns prev_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>jh', ':Gitsigns next_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>hs', ':Gitsigns stage_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>hu', ':Gitsigns undo_stage_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>hr', ':Gitsigns reset_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>hp', ':Gitsigns preview_hunk<CR>', opts)
vim.keymap.set('n', '<leader>haa', ':Gitsigns stage_buffer<CR>', opts)
vim.keymap.set('n', '<leader>har', ':Gitsigns reset_buffer<CR>', opts)
