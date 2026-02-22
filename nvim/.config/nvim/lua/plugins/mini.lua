return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
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
				A = {
					input = ts_input({ outer = "@attribute.outer", inner = "@attribute.inner" }),
				},
				f = {
					input = ts_input({ outer = "@function.outer", inner = "@function.inner" }),
				},
				F = {
					input = ts_input({ outer = "@call.outer", inner = "@call.inner" }),
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
				-- Treesitter textobjects
				a = ts_ai({ a = "@parameter.outer", i = "@parameter.inner" }),
				A = ts_ai({ a = "@attribute.outer", i = "@attribute.inner" }),
				f = ts_ai({ a = "@function.outer", i = "@function.inner" }),
				F = ts_ai({ a = "@call.outer", i = "@call.inner" }),
				c = ts_ai({ a = "@class.outer", i = "@class.inner" }),
				o = ts_ai({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				-- Pattern textobjects
				d = { "%f[%d]%d+" }, -- digits
				e = { -- word with case (camelCase, snake_case segments)
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$",
				},
			},
			search_method = "cover_or_next",
		})

		-- Movement keymaps using mini.ai (replaces nvim-treesitter-textobjects move)
		local ai_move = function(key, direction, ai_type, desc)
			local search_method = direction == "next" and "cover_or_next" or "cover_or_prev"
			vim.keymap.set({ "n", "x", "o" }, key, function()
				MiniAi.move_cursor("left", "a", ai_type, { search_method = search_method })
			end, { desc = desc })
		end

		ai_move("<leader>jf", "next", "f", "Next function")
		ai_move("<leader>kf", "prev", "f", "Previous function")
		ai_move("<leader>ja", "next", "a", "Next parameter")
		ai_move("<leader>ka", "prev", "a", "Previous parameter")
		ai_move("<leader>jA", "next", "A", "Next attribute")
		ai_move("<leader>kA", "prev", "A", "Previous attribute")
		ai_move("<leader>jw", "next", "e", "Next word segment")
		ai_move("<leader>kw", "prev", "e", "Previous word segment")
		ai_move("<leader>jb", "prev", "e", "Previous word segment")

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
