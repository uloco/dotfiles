return {
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		dependencies = { "lewis6991/gitsigns.nvim" },
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
}
