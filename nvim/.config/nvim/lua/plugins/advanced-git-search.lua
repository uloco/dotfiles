return {
	"aaronhallaert/advanced-git-search.nvim",
	cmd = { "AdvancedGitSearch" },
	config = function()
		require("advanced_git_search.snacks").setup({
			diff_plugin = "diffview",
			show_builtin_git_pickers = false,
			entry_default_author_or_date = "author",
		})
	end,
	dependencies = {
		"folke/snacks.nvim",
		"sindrets/diffview.nvim",
	},
	keys = {
		{ "<leader>gss", "<cmd>AdvancedGitSearch<CR>", desc = "Git Search" },
		{ "<leader>gsl", "<cmd>AdvancedGitSearch search_log_content<CR>", desc = "Git Search Log" },
		{ "<leader>gsf", "<cmd>AdvancedGitSearch search_log_content_file<CR>", desc = "Git Search File Log" },
		{ "<leader>gsd", "<cmd>AdvancedGitSearch diff_commit_file<CR>", desc = "Git Diff Commits (file)" },
		{
			"<leader>gsd",
			":'<,'>AdvancedGitSearch diff_commit_line<CR>",
			mode = "v",
			desc = "Git Diff Commits (selection)",
		},
		{ "<leader>gsB", "<cmd>AdvancedGitSearch diff_branch_file<CR>", desc = "Git Diff Branch (file)" },
		{ "<leader>gsC", "<cmd>AdvancedGitSearch changed_on_branch<CR>", desc = "Git Changed on Branch" },
		{ "<leader>gsr", "<cmd>AdvancedGitSearch checkout_reflog<CR>", desc = "Git Checkout Reflog" },
	},
}
