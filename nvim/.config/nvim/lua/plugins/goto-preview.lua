return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	event = "BufEnter",
	config = true,
	keys = {
		{
			"<leader>gd",
			function()
				require("goto-preview").goto_preview_definition()
			end,
			desc = "Preview Definition",
		},
		{
			"<leader>gt",
			function()
				require("goto-preview").goto_preview_type_definition()
			end,
			desc = "Preview Type Definition",
		},
		{
			"<leader>gr",
			function()
				require("goto-preview").goto_preview_references()
			end,
			desc = "Preview References",
		},
		{
			"<leader>gm",
			function()
				require("goto-preview").goto_preview_implementation()
			end,
			desc = "Preview Implementation",
		},
		{
			"<leader>gP",
			function()
				require("goto-preview").close_all_win()
			end,
			desc = "Close All Preview Windows",
		},
	},
}
