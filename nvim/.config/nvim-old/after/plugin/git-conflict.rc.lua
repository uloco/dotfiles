local status, gitConflict = pcall(require, "git-conflict")
if not status then
	return
end

gitConflict.setup({
	default_mappings = false, -- disable buffer local mapping created by this plugin
	disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
})

vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>")
vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>")
vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>")
vim.keymap.set("n", "<leader>cn", "<cmd>GitConflictChooseNone<cr>")
vim.keymap.set("n", "<leader>jc", "<cmd>GitConflictNextConflict<cr>")
vim.keymap.set("n", "<leader>kc", "<cmd>GitConflictPrevConflict<cr>")

-- list all conflicts in quickfix
vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<cr>")
