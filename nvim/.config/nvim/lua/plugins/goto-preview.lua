return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	event = "BufEnter",
	config = true,
	keys = {
		{ "<leader>gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview Definition" },
		{ "<leader>gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview Type Definition" },
		{ "<leader>gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview References" },
		{ "<leader>gm", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview Implementation" },
		{ "<leader>gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close All Preview Windows" },
	},
}
