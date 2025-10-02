return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup(opts)
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
