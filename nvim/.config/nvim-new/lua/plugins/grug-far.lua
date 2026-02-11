return {
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		cmd = "GrugFar",
		keys = {
			{ "<leader>S", "<cmd>GrugFar<CR>", desc = "Open GrugFar" },
			{
				"<leader>ss",
				function()
					require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				desc = "Search current word",
			},
			{
				"<leader>ss",
				function()
					require("grug-far").with_visual_selection()
				end,
				mode = "v",
				desc = "Search current selection",
			},
		},
	},
}
