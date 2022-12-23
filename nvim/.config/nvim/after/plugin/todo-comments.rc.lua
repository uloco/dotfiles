local status, todo = pcall(require, "todo-comments")
if (not status) then return end

todo.setup()

vim.keymap.set("n", "<leader>jt", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "<leader>kt", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>lT', '<cmd>TodoTelescope<cr>', opts)
vim.keymap.set('n', '<leader>xT', '<cmd>TodoTrouble<cr>', opts)
