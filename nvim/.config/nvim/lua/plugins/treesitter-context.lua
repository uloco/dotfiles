return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"[x",
			function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end,
			desc = "Go to context",
		},
	},
}
