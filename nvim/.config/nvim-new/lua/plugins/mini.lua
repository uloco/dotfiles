return {
	"nvim-mini/mini.nvim",
	lazy = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		local ts_input = require("mini.surround").gen_spec.input.treesitter
		require("mini.surround").setup({
			n_lines = 500,
			custom_surroundings = {
				-- Use treesitter to find surroundings
				a = {
					input = ts_input({ outer = "@parameter.outer", inner = "@parameter.inner" }),
				},
				f = {
					input = ts_input({ outer = "@call.outer", inner = "@call.inner" }),
				},
				m = {
					input = ts_input({ outer = "@function.outer", inner = "@function.inner" }),
				},
				o = {
					input = ts_input({ outer = "@block.outer", inner = "@block.inner" }),
				},
			},
		})

		require("mini.pairs").setup()

		local ts_ai = require("mini.ai").gen_spec.treesitter
		require("mini.ai").setup({
			n_lines = 500,
			custom_textobjects = {
				-- Use treesitter to find textobjects
				a = ts_ai({ a = "@parameter.outer", i = "@parameter.inner" }),
				f = ts_ai({ a = "@call.outer", i = "@call.inner" }),
				m = ts_ai({ a = "@function.outer", i = "@function.inner" }),
				o = ts_ai({ a = "@block.outer", i = "@block.inner" }),
				x = ts_ai({ a = "@attribute.outer", i = "@attribute.inner" }),
			},
		})

		require("mini.files").setup({
			mappings = {
				close = "<ESC>",
			},
		})

		require("mini.splitjoin").setup()

		require("mini.move").setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode.
				left = "<C-S-h>",
				right = "<C-S-l>",
				down = "<C-S-j>",
				up = "<C-S-k>",

				-- Move current line in Normal mode
				line_left = "<C-S-h>",
				line_right = "<C-S-l>",
				line_down = "<C-S-j>",
				line_up = "<C-S-k>",
			},
			options = {
				reindent_linewise = false,
			},
		})
	end,
	keys = {
		{ "<leader>fb", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Open MiniFiles" },
	},
}
