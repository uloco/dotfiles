return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--glob=!e2e",
      "--glob=!translations",
      "--glob=!*.json",
      "--hidden"
    },
    pattern = [[\b(KEYWORDS):]],
  },
},
config = function(_, opts)
  require("todo-comments").setup(opts)
  vim.keymap.set("n", "<leader>jt", function()
    require("todo-comments").jump_next()
  end, { desc = "Next todo comment" })
  vim.keymap.set("n", "<leader>kt", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous todo comment" })
  local opts_map = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>lT', '<cmd>TodoTelescope<cr>', opts_map)
  vim.keymap.set('n', '<leader>xT', '<cmd>TodoTrouble<cr>', opts_map)
end,
}
