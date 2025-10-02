return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

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
}
