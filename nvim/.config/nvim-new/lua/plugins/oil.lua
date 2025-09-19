return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-mini/mini.nvim" },
	lazy = false,
	keys = {
		{ "<leader>fb", "<cmd>Oil --float %:p:h<cr>", desc = "Open Oil" },
	},
}
