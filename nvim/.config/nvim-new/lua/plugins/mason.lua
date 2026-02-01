return {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "neovim/nvim-lspconfig" },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"tree-sitter-cli",
					"python-lsp-server",
					"tailwindcss-language-server",
					"vtsls",
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
	opts = {
		ensure_installed = {
			"lua_ls",
		},
		automatic_enable = {
			exclude = {
				"ts_ls",
			},
		},
	},
}
