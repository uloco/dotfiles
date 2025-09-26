return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"b0o/schemastore.nvim",
	},
	keys = {
		{
			"<leader>ke",
			function()
				vim.diagnostic.jump({ count = -1 })
			end,
			desc = "Previous Diagnostic",
		},
		{
			"<leader>je",
			function()
				vim.diagnostic.jump({ count = 1 })
			end,
			desc = "Next Diagnostic",
		},
		{
			"K",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "Line Diagnostics",
		},
		{
			"gh",
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Hover Documentation",
		},
		{
			"<F2>",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename Symbol",
		},
		{
			"<Leader>ca",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "Code Action",
		},
	},
}
-- TODO: add to glance?
-- { "<leader>gp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
-- { "<leader>gP", "<Cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
