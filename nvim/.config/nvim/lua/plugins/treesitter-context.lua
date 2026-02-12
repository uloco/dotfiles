return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>uc", "<cmd>TSContext toggle<cr>", desc = "Toggle TS Context" },
		{
			"[x",
			function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end,
			desc = "Go to context",
		},
	},
}
