return {
  "lukas-reineke/virt-column.nvim",
  config = function(_, opts)
    local virtColumn = require('virt-column')
    virtColumn.setup({
      char = "┊",
      virtcolumn = "80"
    })
    local augroup_term_column = vim.api.nvim_create_augroup("Term-Virt-Column", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
      group = augroup_term_column,
      pattern = 'term://*',
      callback = function(ev)
        virtColumn.setup_buffer { virtcolumn = '' }
      end
    })
  end,
}
