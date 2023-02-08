local status, todo = pcall(require, "todo-comments")
if (not status) then return end

todo.setup({
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--glob=!e2e",
      "--hidden"
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})

vim.keymap.set("n", "<leader>jt", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "<leader>kt", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>lT', '<cmd>TodoTelescope<cr>', opts)
vim.keymap.set('n', '<leader>xT', '<cmd>TodoTrouble<cr>', opts)
