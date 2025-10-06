vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
		-- save all open buffrs after rename
		vim.cmd("wall")
	end,
})

return {
	"nvim-mini/mini.nvim",
	lazy = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		require("mini.surround").setup()

		require("mini.files").setup()

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
