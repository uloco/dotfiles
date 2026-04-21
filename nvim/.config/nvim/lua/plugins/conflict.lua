return {
	"niekdomi/conflict.nvim",
	event = "BufReadPre",
	opts = {
		default_mappings = {
			current = "<leader>co",
			incoming = "<leader>ct",
			both = "<leader>cb",
			base = "<leader>cp",
			none = "<leader>cn",
			next = "<leader>jc",
			prev = "<leader>kc",
		},
		show_actions = true, -- Mouse support/clickable label (optional)
		disable_diagnostics = true, -- Disable diagnostics like old config
	},
}
