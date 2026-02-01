return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  enabled = false,
	opts = {
		settings = {
			expose_as_code_action = "all",
			tsserver_file_preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	keys = {
		{ "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
		{ "<leader>cr", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
	},
}
