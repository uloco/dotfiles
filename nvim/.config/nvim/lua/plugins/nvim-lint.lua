return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "oxlint" },
			javascriptreact = { "oxlint" },
			typescript = { "oxlint" },
			typescriptreact = { "oxlint" },
			svelte = { "oxlint" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})

		-- Lint current buffer on load
		lint.try_lint()
	end,
}
