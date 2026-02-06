return {
	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "git",
			icons = true,
			quick_select = "123456789",
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		keys = {
			{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			{ "<leader>A", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
			{ "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
			{ "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
			{ "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
			{ "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Grapple select 4" },
			{ "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "Grapple select 5" },
			{ "<leader>6", "<cmd>Grapple select index=6<cr>", desc = "Grapple select 6" },
			{ "<leader>7", "<cmd>Grapple select index=7<cr>", desc = "Grapple select 7" },
			{ "<leader>8", "<cmd>Grapple select index=8<cr>", desc = "Grapple select 8" },
			{ "<leader>9", "<cmd>Grapple select index=9<cr>", desc = "Grapple select 9" },
			{ "<A-S-i>", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple next tag" },
			{ "<A-S-u>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple previous tag" },
		},
	},
	{
		"will-lynas/grapple-line.nvim",
		version = "1.x",
		dependencies = { "cbochs/grapple.nvim" },
		opts = {
			number_of_files = 9,
			mode = "unique_filename",
			overflow = "ellipsis",
			show_names = false,
		},
	},
}
