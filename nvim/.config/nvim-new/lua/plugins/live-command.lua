return {
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		opts = {
			commands = {
				Norm = { cmd = "norm" },
				Glob = { cmd = "g", hl_range = { 1, -1, kind = "visible" } },
			},
		},
	},
}
