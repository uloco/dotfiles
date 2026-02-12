return {
	"yioneko/nvim-vtsls",
	lazy = true,
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	keys = {
		{ "<leader>ci", "<cmd>VtsExec add_missing_imports<cr>", desc = "Add Missing Imports" },
		{ "<leader>co", "<cmd>VtsExec organize_imports<cr>", desc = "Organize Imports" },
		{ "<leader>cu", "<cmd>VtsExec remove_unused_imports<cr>", desc = "Remove Unused Imports" },
		{ "<leader>cr", "<cmd>VtsExec rename_file<cr>", desc = "Rename File" },
		{ "<leader>cs", "<cmd>VtsExec source_actions<cr>", desc = "Source Actions" },
		{ "<leader>cf", "<cmd>VtsExec fix_all<cr>", desc = "Fix All" },
		{ "<leader>cg", "<cmd>VtsExec goto_source_definition<cr>", desc = "Go to Source Definition" },
	},
}
