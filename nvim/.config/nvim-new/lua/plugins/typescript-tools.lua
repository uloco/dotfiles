return {
	"pmizio/typescript-tools.nvim",
	opts = {
		settings = {
			expose_as_code_action = "all",
			tsserver_file_preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
	keys = {
		{ "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
		{ "<leader>cr", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
	},
}
