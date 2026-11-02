return {
	{
		"petertriho/nvim-scrollbar",
		-- v2 is on this branch until it replaces main on 2026-11-16; then remove the line
		branch = "refactor/v2",
		event = "BufReadPost",
		dependencies = { "lewis6991/gitsigns.nvim" },
		opts = {
			providers = { gitsigns = true },
		},
	},
}
