return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		prefix = "<leader>",
		preset = "helix",
		spec = {
			{
				mode = { "n", "x" },
				{ "<leader>G", group = "Atlas" },
				{ "<leader>a", group = "AI" },
				{ "<leader>c", group = "Code / Conflicts" },
				{ "<leader>d", group = "Diff / History" },
				{ "<leader>f", group = "Files / Buffers" },
				{ "<leader>g", group = "Goto / Git" },
				{ "<leader>gs", group = "Git Search" },
				{ "<leader>h", group = "Hunks / Highlight" },
				{ "<leader>j", group = "Next", mode = { "n", "x", "o" } },
				{ "<leader>k", group = "Previous", mode = { "n", "x", "o" } },
				{ "<leader>l", group = "Pickers" },
				{ "<leader>s", group = "Search / Source" },
				{ "<leader>t", group = "Tests" },
				{ "<leader>u", group = "Toggles" },
				{ "<leader>v", group = "Cursors" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
