return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	keys = {
		{ "<C-S-P>", "<cmd>Inspect<cr>", mode = "n", desc = "Highlight Capture" },
	},
	opts = {
		ensure_installed = {
			"bash",
			"typescript",
			"tsx",
			"javascript",
			"jsx",
			"java",
			"elixir",
			"json",
			"css",
			"lua",
			"make",
			"dockerfile",
			"gitattributes",
			"gitignore",
			"graphql",
			"groovy",
			"html",
			"jsdoc",
			"php",
			"python",
			"ruby",
			"regex",
			"scss",
			"toml",
			"yaml",
			"vim",
			"vimdoc",
			"swift",
			"svelte",
			"rust",
			"r",
			"go",
			"cpp",
			"sql",
			"kotlin",
			"dart",
			"scala",
			"haskell",
			"erlang",
			"markdown",
			"markdown_inline",
			"objc",
			"ini",
		},
	},
	config = function(plugin, opts)
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install(opts.ensure_installed)

		local parsersInstalled = require("nvim-treesitter.config").get_installed("parsers")
		for _, parser in pairs(parsersInstalled) do
			local filetypes = vim.treesitter.language.get_filetypes(parser)
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = filetypes,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end
	end,
}
