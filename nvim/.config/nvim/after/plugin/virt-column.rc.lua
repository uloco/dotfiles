local status, virtColumn = pcall(require, 'virt-column')
if (not status) then return end

virtColumn.setup({
  char = "┊",
  virtcolumn = "80"
})

-- Auto insert mode when entering terminal
local augroup_term_column = vim.api.nvim_create_augroup("Term-Virt-Column", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
  group = augroup_term_column,
  pattern = 'term://*',
  -- command = 'startinsert'
  callback = function(ev)
    virtColumn.setup_buffer { virtcolumn = '' }
  end
})



