return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	event = "BufEnter",
	opts = {
		vim_ui_input = false,
		references = {
			provider = "snacks",
		},
	},
	config = function(_, opts)
		local goto_preview = require("goto-preview")
		goto_preview.setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "goto-preview",
			callback = function()
				vim.wo.winbar = ""
			end,
		})
	end,
	keys = {
		{
			"<leader>gd",
			function()
				require("goto-preview").goto_preview_definition()
			end,
			desc = "Preview Definition",
		},
		{
			"<leader>gD",
			function()
				require("goto-preview").goto_preview_declaration()
			end,
			desc = "Preview Declaration",
		},
		{
			"<leader>gt",
			function()
				require("goto-preview").goto_preview_type_definition()
			end,
			desc = "Preview Type Definition",
		},
		{
			"<leader>gr",
			function()
				require("goto-preview").goto_preview_references()
			end,
			desc = "Preview References",
		},
		{
			"<leader>gm",
			function()
				require("goto-preview").goto_preview_implementation()
			end,
			desc = "Preview Implementation",
		},
		{
			"<leader>gP",
			function()
				require("goto-preview").close_all_win()
			end,
			desc = "Close All Preview Windows",
		},
	},
}
