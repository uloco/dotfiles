return {
	"kevinhwang91/nvim-ufo",
	lazy = false,
	dependencies = {
		"kevinhwang91/promise-async",
	},
	opts = {
		provider_selector = function()
			return { "lsp", "indent" }
		end,
	},
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
	},
}
