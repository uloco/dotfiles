return {
	"aaronhallaert/advanced-git-search.nvim",
	cmd = { "AdvancedGitSearch" },
	config = function()
		require("advanced_git_search.snacks").setup({
			-- Use diffview for showing diffs (already configured in the setup)
			diff_plugin = "diffview",
			-- Show author by default in entries
			entry_default_author_or_date = "author",
			-- Optionally show builtin git pickers when executing show_custom_functions
			show_builtin_git_pickers = true,
			-- Git flags for better formatting (optional)
			git_flags = {},
			git_diff_flags = {},
			git_log_flags = {},
			-- Keymaps (defaults are good, but explicitly defined for clarity)
			keymaps = {
				toggle_date_author = "<C-w>",
				open_commit_in_browser = "<C-o>",
				copy_commit_hash = "<C-y>",
				show_entire_commit = "<C-e>",
			},
		})
	end,
	dependencies = {
		"folke/snacks.nvim",
		"sindrets/diffview.nvim",
	},
	keys = {
		-- Primary git search menu
		{
			"<leader>gs",
			":AdvancedGitSearch show_custom_functions<CR>",
			desc = "Git Search Menu",
		},
		-- Search git log content
		{
			"<leader>gsl",
			":AdvancedGitSearch search_log_content<CR>",
			desc = "Search Git Log Content",
		},
		-- Search git log for current file
		{
			"<leader>gsf",
			":AdvancedGitSearch search_log_content_file<CR>",
			desc = "Search Git Log (Current File)",
		},
		-- Diff file with commit
		{
			"<leader>gsd",
			":AdvancedGitSearch diff_commit_file<CR>",
			desc = "Diff File with Commit",
		},
		-- Diff file with branch
		{
			"<leader>gsb",
			":AdvancedGitSearch diff_branch_file<CR>",
			desc = "Diff File with Branch",
		},
		-- Changed files on branch
		{
			"<leader>gsc",
			":AdvancedGitSearch changed_on_branch<CR>",
			desc = "Changed Files on Branch",
		},
		-- Visual mode: diff line history
		{
			"<leader>gs",
			":'<,'>AdvancedGitSearch diff_commit_line<CR>",
			mode = "v",
			desc = "Diff Line History (Visual)",
		},
	},
}
