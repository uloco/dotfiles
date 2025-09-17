require("typescript-tools").setup({
	settings = {
		expose_as_code_action = "all",
		tsserver_file_preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
})

vim.keymap.set({ "n" }, "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>")
vim.keymap.set({ "n" }, "<leader>cr", "<cmd>TSToolsRenameFile<cr>")
