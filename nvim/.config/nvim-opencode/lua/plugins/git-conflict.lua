return {
	"akinsho/git-conflict.nvim",
	tag = "v2.1.0",
	opts = {
		default_mappings = false,
		disable_diagnostics = true,
	},
	config = function(_, opts)
		require("git-conflict").setup(opts)
		vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>")
		vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>")
		vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>")
		vim.keymap.set("n", "<leader>cn", "<cmd>GitConflictChooseNone<cr>")
		vim.keymap.set("n", "<leader>jc", "<cmd>GitConflictNextConflict<cr>")
		vim.keymap.set("n", "<leader>kc", "<cmd>GitConflictPrevConflict<cr>")
		vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<cr>")
	end,
}
