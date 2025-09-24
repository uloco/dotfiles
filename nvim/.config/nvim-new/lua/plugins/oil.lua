return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		float = {
			max_width = 0.5,
			win_options = {
				winblend = 15,
			},
		},
		keys = {
			["<C-c>"] = "actions.close",
			-- ["<C-d>"] = "actions.preview_scroll_down",
			-- ["<C-u>"] = "actions.preview_scroll_up",
		},
	},
	dependencies = { "nvim-mini/mini.nvim" },
	lazy = false,
	keys = {
		{ "<leader>fb", "<cmd>Oil --float %:p:h<cr>", desc = "Open Oil" },
	},
}
