-- not yet configured fully
return {
	"aaronhallaert/advanced-git-search.nvim",
	cmd = { "AdvancedGitSearch" },
	config = function()
		require("advanced_git_search.snacks").setup({
			-- Insert Config here
		})
	end,
	dependencies = {
		"folke/snacks.nvim",
	},
}
