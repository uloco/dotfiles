return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"lua_ls",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-tool-installer.nvim", opts = {} },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"tree-sitter-cli",
					"python-lsp-server",
					"tailwindcss-language-server",
					"typescript-language-server",
					"svelte-language-server",
					"emmet-language-server",
					"prettierd",
					"stylua",
					"bash-language-server",
					"beautysh",
					"eslint_d",
					"graphql-language-service-cli",
					"json-lsp",
					"lua-language-server",
					"markdownlint",
					"shfmt",
					"yaml-language-server",
				},
			},
		},
	},
}
