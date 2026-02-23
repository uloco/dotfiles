return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = { enabled = true },
			char = { enabled = true },
		},
	},
	-- stylua: ignore
	keys = {
		{ "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
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
