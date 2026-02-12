return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
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
		{
			"zp",
			function()
				require("ufo").peekFoldedLinesUnderCursor()
			end,
			desc = "Peek fold",
		},
		{
			"<leader>jz",
			function()
				require("ufo").goNextClosedFold()
			end,
			desc = "Go to next closed fold",
		},
		{
			"<leader>kz",
			function()
				require("ufo").goPreviousClosedFold()
			end,
			desc = "Go to previous closed fold",
		},
	},
}
