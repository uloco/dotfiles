return {
  "folke/trouble.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {},
config = function(_, opts)
  require('trouble').setup(opts)
  local opts_map = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts_map)
  vim.keymap.set('n', '<leader>xW', '<cmd>Trouble workspace_diagnostics<cr>', opts_map)
  vim.keymap.set('n', '<leader>xD', '<cmd>Trouble document_diagnostics<cr>', opts_map)
  vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp_references<cr>', opts_map)
  vim.keymap.set('n', '<leader>xd', '<cmd>Trouble lsp_definitions<cr>', opts_map)
  vim.keymap.set('n', '<leader>xt', '<cmd>Trouble lsp_type_definitions<cr>', opts_map)
  vim.keymap.set('n', '<leader>xi', '<cmd>Trouble lsp_implementations<cr>', opts_map)
  vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', opts_map)
end,
}
