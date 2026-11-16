return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	opts = {
		provider_selector = function()
			return { "lsp", "indent" }
		end,
		close_fold_kinds_for_ft = {
			default = { "imports" },
		},
	},
	config = function(_, opts)
		require("ufo").setup(opts)

		-- Fold imports before the first redraw; ufo folds async (flicker) but keeps manual closed folds.
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = { "*.ts", "*.tsx" },
			callback = function(args)
				local buf = args.buf
				if vim.w.snacks_picker_preview then
					-- the preview inherits the folds of the last window showing this buffer
					vim.cmd("silent! normal! zE")
					return
				end
				-- once per window per buffer lifetime (folds are window-local; :bdelete resets)
				local win = tostring(vim.api.nvim_get_current_win())
				local wins = vim.b[buf].imports_prefolded_wins or {}
				if wins[win] then
					return
				end
				wins[win] = true
				vim.b[buf].imports_prefolded_wins = wins

				local parser = vim.treesitter.get_parser(buf, nil, { error = false })
				if not parser then
					return
				end
				local query = vim.treesitter.query.parse(parser:lang(), "(import_statement) @import")
				local first, last
				for _, node in query:iter_captures(parser:parse()[1]:root(), buf) do
					local start_row, _, end_row = node:range()
					first = first or start_row + 1
					last = end_row + 1
				end
				if first and last > first then
					vim.wo.foldmethod = "manual"
					-- :fold creates the fold closed
					vim.cmd(("silent %d,%dfold"):format(first, last))
				end
			end,
		})
	end,
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
		{
			"zp",
			function()
				require("ufo").peekFoldedLinesUnderCursor()
			end,
			desc = "Peek fold",
		},
		{
			"<leader>jz",
			function()
				require("ufo").goNextClosedFold()
			end,
			desc = "Go to next closed fold",
		},
		{
			"<leader>kz",
			function()
				require("ufo").goPreviousClosedFold()
			end,
			desc = "Go to previous closed fold",
		},
	},
}
