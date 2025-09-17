return {
	"folke/which-key.nvim",
	opts = {
		prefix = "<leader>",
		preset = "helix",
	},
	config = function(_, opts)
		require("which-key").setup(opts)
	end,
}
