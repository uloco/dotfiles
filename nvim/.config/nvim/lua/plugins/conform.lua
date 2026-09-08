return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>ö",
			function()
				require("conform").format()
			end,
			mode = "",
			desc = "Format buffer",
		},
		{
			"<leader>uf",
			function()
				Snacks.toggle({
					name = "Auto Format (Buffer)",
					get = function()
						return not vim.b.disable_autoformat
					end,
					set = function(state)
						vim.b.disable_autoformat = not state
					end,
				}):toggle()
			end,
			desc = "Toggle auto format (buffer)",
		},
		{
			"<leader>uF",
			function()
				Snacks.toggle({
					name = "Auto Format",
					get = function()
						return not vim.g.disable_autoformat
					end,
					set = function(state)
						vim.g.disable_autoformat = not state
					end,
				}):toggle()
			end,
			desc = "Toggle auto format (global)",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters_by_ft = {
			kotlin = { "ktlint" },
			lua = { "stylua", lsp_format = "never" },
			swift = { "swift" },
			javascript = { "oxfmt", "prettierd" },
			javascriptreact = { "oxfmt", "prettierd" },
			typescript = { "oxfmt", "prettierd" },
			typescriptreact = { "oxfmt", "prettierd" },
			css = { "oxfmt", "prettierd" },
			less = { "oxfmt", "prettierd" },
			scss = { "oxfmt", "prettierd" },
			graphql = { "oxfmt", "prettierd" },
			json = { "oxfmt", "prettierd" },
			yaml = { "oxfmt", "prettierd" },
			markdown = { "oxfmt", "prettierd" },
			html = { "oxfmt", "prettierd" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "beautysh" },
			toml = { "taplo" },
		},
		default_format_opts = {
			lsp_format = "fallback",
			stop_after_first = true,
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
			beautysh = {
				prepend_args = { "-i", "2" },
			},
		},
	},
}
