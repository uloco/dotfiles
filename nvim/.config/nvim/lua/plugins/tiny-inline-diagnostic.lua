return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			options = {
				multilines = {
					enabled = true,
				},
				show_all_diags_on_cursorline = true,
			},
		})
		vim.diagnostic.config({ virtual_text = false })
	end,
	keys = {
		{ "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", desc = "Toggle Inline Diagnostics" },
	},
}
