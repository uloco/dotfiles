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
			search_method = "cover",
		})

		-- Backward-compatible select keymaps (matching old treesitter-textobjects bindings)
		-- af/if -> function (mini.ai uses 'm' for function, but old config used 'f')
		vim.keymap.set({ "x", "o" }, "af", function()
			MiniAi.select_textobject("a", "m")
		end, { desc = "Select around function" })
		vim.keymap.set({ "x", "o" }, "if", function()
			MiniAi.select_textobject("i", "m")
		end, { desc = "Select inside function" })

		-- aA/iA -> attribute (mini.ai uses 'x' for attribute, but old config used 'A')
		vim.keymap.set({ "x", "o" }, "aA", function()
			MiniAi.select_textobject("a", "x")
		end, { desc = "Select around attribute" })
		vim.keymap.set({ "x", "o" }, "iA", function()
			MiniAi.select_textobject("i", "x")
		end, { desc = "Select inside attribute" })

		-- Movement keymaps using MiniAi.move_cursor()
		-- Move to next/previous function
		vim.keymap.set({ "n", "x", "o" }, "<leader>jf", function()
			MiniAi.move_cursor("left", "a", "m", { search_method = "next" })
		end, { desc = "Next function start" })
		vim.keymap.set({ "n", "x", "o" }, "<leader>jF", function()
			MiniAi.move_cursor("right", "a", "m", { search_method = "next" })
		end, { desc = "Next function end" })
		vim.keymap.set({ "n", "x", "o" }, "<leader>kf", function()
			MiniAi.move_cursor("left", "a", "m", { search_method = "prev" })
		end, { desc = "Previous function start" })
		vim.keymap.set({ "n", "x", "o" }, "<leader>kF", function()
			MiniAi.move_cursor("right", "a", "m", { search_method = "prev" })
		end, { desc = "Previous function end" })

		-- Move to next/previous parameter
		vim.keymap.set({ "n", "x", "o" }, "<leader>ja", function()
			MiniAi.move_cursor("left", "a", "a", { search_method = "next" })
		end, { desc = "Next parameter" })
		vim.keymap.set({ "n", "x", "o" }, "<leader>ka", function()
			MiniAi.move_cursor("left", "a", "a", { search_method = "prev" })
		end, { desc = "Previous parameter" })

		-- Move to next/previous attribute
		vim.keymap.set({ "n", "x", "o" }, "<leader>jA", function()
			MiniAi.move_cursor("left", "a", "x", { search_method = "next" })
		end, { desc = "Next attribute" })
		vim.keymap.set({ "n", "x", "o" }, "<leader>kA", function()
			MiniAi.move_cursor("left", "a", "x", { search_method = "prev" })
		end, { desc = "Previous attribute" })

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
