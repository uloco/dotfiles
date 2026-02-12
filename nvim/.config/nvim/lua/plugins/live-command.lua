return {
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		config = function()
			require("live-command").setup({
				commands = {
					Norm = { cmd = "norm" },
					Glob = { cmd = "g", hl_range = { 1, -1, kind = "visible" } },
				},
			})
		end,
	},
}
