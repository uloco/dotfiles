return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local none_ls = require("null-ls")
		none_ls.setup({
			sources = {
				none_ls.builtins.diagnostics.fish,
				require("none-ls.code_actions.eslint_d"),
				require("none-ls.diagnostics.eslint_d").with({
					diagnostics_format = "[eslint] #{m}\n(#{c})",
				}),
				none_ls.builtins.formatting.prettierd,
			},
		})
	end,
}
