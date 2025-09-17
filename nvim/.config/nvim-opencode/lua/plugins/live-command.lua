return {
	"smjonas/live-command.nvim",
	tag = "*",
	main = "live-command",
	-- disable = true,
	opts = {
		commands = {
			Norm = { cmd = "norm" },
			Glob = { cmd = "g" },
		},
	},
}
