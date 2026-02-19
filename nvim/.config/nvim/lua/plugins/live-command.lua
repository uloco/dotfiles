return {
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
    main = "live-command",
		opts = {
			commands = {
				Norm = { cmd = "norm" },
				Glob = { cmd = "g", hl_range = { 1, -1, kind = "visible" } },
			},
		},
	},
}
