return {
	"folke/flash.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = {
		modes = {
			search = { enabled = true },
			char = { enabled = true },
		},
	},
	keys = {
		{
			"gs",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
		{
			"<C-Space>",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter({
					actions = {
						["<C-Space>"] = "next",
						["<BS>"] = "prev",
					},
				})
			end,
			desc = "Treesitter Incremental Selection",
		},
	},
}
