vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

return {
	"nvim-mini/mini.nvim",
	lazy = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		-- require("mini.surround").setup({
		-- 	mappings = {
		-- 		add = "gsa", -- Add surrounding in Normal and Visual modes
		-- 		delete = "gsd", -- Delete surrounding
		-- 		find = "gsf", -- Find surrounding (to the right)
		-- 		find_left = "gsF", -- Find surrounding (to the left)
		-- 		highlight = "gsh", -- Highlight surrounding
		-- 		replace = "gsr", -- Replace surrounding
		-- 		update_n_lines = "gsn", -- Update `n_lines`
		-- 	},
		-- })
		-- require("mini.pairs").setup()

		require("mini.files").setup()

		require("mini.move").setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode.
				left = "<C-h>",
				right = "<C-l>",
				down = "<C-j>",
				up = "<C-k>",

				-- Move current line in Normal mode
				line_left = "<C-h>",
				line_right = "<C-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
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
