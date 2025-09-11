return {
  "lewis6991/gitsigns.nvim",
  opts = {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
  },
  numhl = true,
  current_line_blame_formatter = '     <author>, <author_time:%Y-%m-%d> - <summary>',
},
config = function(_, opts)
  require('gitsigns').setup(opts)
  local opts_map = { noremap = true, silent = true }
  vim.keymap.set('n', '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts_map)
  vim.keymap.set('n', '<Leader>kh', ':Gitsigns prev_hunk<CR>zz', opts_map)
  vim.keymap.set('n', '<Leader>jh', ':Gitsigns next_hunk<CR>zz', opts_map)
  vim.keymap.set({ 'n', 'v' }, '<leader>ha', ':Gitsigns stage_hunk<cr>', opts_map)
  vim.keymap.set('n', '<Leader>hu', ':Gitsigns undo_stage_hunk<CR>', opts_map)
  vim.keymap.set({ 'n', 'v' }, '<Leader>hr', ':Gitsigns reset_hunk<CR>', opts_map)
  vim.keymap.set('n', '<Leader>hp', ':Gitsigns preview_hunk<CR>', opts_map)
  vim.keymap.set('n', '<leader>hA', ':Gitsigns stage_buffer<CR>', opts_map)
  vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer<CR>', opts_map)
end,
}
