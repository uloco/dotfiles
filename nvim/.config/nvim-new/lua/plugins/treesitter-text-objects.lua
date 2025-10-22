return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	branch = "main",
	enabled = true,
	lazy = false,
	config = function()
		-- configuration
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},
			move = {
				-- whether to set jumps in the jumplist
				set_jumps = true,
			},
		})

		-- keymaps
		-- select
		local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
		vim.keymap.set({ "x", "o" }, "aa", function()
			select_textobject("@parameter.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ia", function()
			select_textobject("@parameter.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "aA", function()
			select_textobject("@attribute.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "iA", function()
			select_textobject("@attribute.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "af", function()
			select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			select_textobject("@function.inner", "textobjects")
		end)

		-- move
		local move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "<leader>jf", function()
			move.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "<leader>jF", function()
			move.goto_next_end("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "<leader>kf", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "<leader>kF", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "<leader>ja", function()
			move.goto_next_start("@parameter.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "<leader>ka", function()
			move.goto_previous_start("@parameter.outer", "textobjects")
		end, { desc = "Previous parameter" })

		vim.keymap.set({ "n", "x", "o" }, "<leader>jA", function()
			move.goto_next_start("@attribute.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "<leader>kA", function()
			move.goto_previous_start("@attribute.outer", "textobjects")
		end)
	end,
}
