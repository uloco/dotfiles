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

vim.keymap.set('n', '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', '<Leader>kh', ':Gitsigns prev_hunk<CR>')
vim.keymap.set('n', '<Leader>jh', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', '<Leader>hs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', '<Leader>hu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', '<Leader>hr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', '<Leader>hp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>haa', ':Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<leader>har', ':Gitsigns reset_buffer<CR>')
