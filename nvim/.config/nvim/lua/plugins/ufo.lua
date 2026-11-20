-- Buffer setting overrides the global one; folding imports is on by default.
local function fold_imports_enabled(buf)
	local b = vim.b[buf or 0].fold_imports
	if b ~= nil then
		return b
	end
	return vim.g.fold_imports ~= false
end

-- 1-based lines of merge conflict start markers.
local function conflict_rows(buf)
	local rows = {}
	for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
		if line:find("^<<<<<<<") then
			rows[#rows + 1] = i
		end
	end
	return rows
end

-- Folds hide conflicts, so open every fold that contains one in the current window.
local function open_conflicts()
	for _, row in ipairs(conflict_rows(0)) do
		vim.cmd(("silent! %dfoldopen!"):format(row))
	end
end

-- 1-based first/last line of the import block, via treesitter.
local function import_range(buf)
	local parser = vim.treesitter.get_parser(buf, nil, { error = false })
	if not parser then
		return
	end
	local ok, query = pcall(vim.treesitter.query.parse, parser:lang(), "(import_statement) @import")
	if not ok then
		return
	end
	local first, last
	for _, node in query:iter_captures(parser:parse()[1]:root(), buf) do
		local start_row, _, end_row = node:range()
		first = first or start_row + 1
		last = end_row + 1
	end
	if first and last > first then
		return first, last
	end
end

-- Open or close the import fold in the current window.
local function apply_fold_imports(state)
	local first, last = import_range(vim.api.nvim_get_current_buf())
	if not first then
		return
	end
	if not state then
		vim.cmd(("silent! %dfoldopen!"):format(first))
		return
	end
	vim.cmd(("silent! %dfoldclose"):format(first))
	if vim.fn.foldclosed(first) == -1 then
		vim.wo.foldmethod = "manual"
		vim.cmd(("silent %d,%dfold"):format(first, last))
	end
end

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
	},
	config = function(_, opts)
		require("ufo").setup(opts)

		-- ufo keeps a reference to this table, so resolve the kinds lazily to honor the toggle.
		local kinds = require("ufo.config").close_fold_kinds_for_ft
		kinds.default = nil
		setmetatable(kinds, {
			__index = function()
				if not fold_imports_enabled() or #conflict_rows(0) > 0 then
					return {}
				end
				return { "imports" }
			end,
		})

		-- ufo applies folds async and may restore closed ones after a reload, so open conflicts after it.
		vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "FileChangedShellPost" }, {
			callback = function(args)
				vim.defer_fn(function()
					if vim.api.nvim_get_current_buf() == args.buf then
						open_conflicts()
					end
				end, 50)
			end,
		})

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
				if not fold_imports_enabled(buf) or #conflict_rows(buf) > 0 then
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

				local first, last = import_range(buf)
				if first then
					vim.wo.foldmethod = "manual"
					-- :fold creates the fold closed
					vim.cmd(("silent %d,%dfold"):format(first, last))
				end
			end,
		})

		Snacks.toggle({
			name = "Fold Imports (Buffer)",
			get = function()
				return fold_imports_enabled(0)
			end,
			set = function(state)
				vim.b.fold_imports = state
				apply_fold_imports(state)
			end,
		}):map("<leader>ui")

		Snacks.toggle({
			name = "Fold Imports",
			get = function()
				return vim.g.fold_imports ~= false
			end,
			set = function(state)
				vim.g.fold_imports = state
				-- project-wide toggle wins over buffer overrides
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					vim.b[buf].fold_imports = nil
				end
				apply_fold_imports(state)
			end,
		}):map("<leader>uI")
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
