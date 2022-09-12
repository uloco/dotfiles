local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
  },

}

vim.keymap.set('n', '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>')
