return {
	"neovim/nvim-lspconfig",
	lazy = true, -- loaded by mason-lspconfig as dependency
	dependencies = {
		"b0o/schemastore.nvim",
		"yioneko/nvim-vtsls",
	},
	config = function()
		-- Server-specific configurations
		-- These override defaults for servers enabled by mason-lspconfig's automatic_enable

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					hint = {
						enable = true,
						arrayIndex = "Enable",
						setType = true,
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
				},
			},
		})

		vim.lsp.config("jsonls", {
			filetypes = { "json", "jsonc" },
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					validate = true,
				},
			},
		})

		vim.lsp.config("graphql", {
			on_attach = function(client)
				client.server_capabilities.workspaceSymbolProvider = false
			end,
			filetypes = {
				"graphql",
				"typescriptreact",
				"typescript",
				"javascript",
				"javascriptreact",
			},
		})

		vim.lsp.config("vtsls", {
			settings = {
				typescript = {
					preferences = {
						useAliasesForRenames = false,
					},
				},
				javascript = {
					preferences = {
						useAliasesForRenames = false,
					},
				},
			},
		})
	end,
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
