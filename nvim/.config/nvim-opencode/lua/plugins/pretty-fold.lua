return {
	"bbjornstad/pretty-fold.nvim",
	opts = {
		fill_char = "—",
	},
	config = function(_, opts)
		require("pretty-fold").setup(opts)
	end,
}
