return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*",
	opts = {
		pre_hook = function()
			vim.g.minipairs_disable = true
		end,
		post_hook = function()
			vim.g.minipairs_disable = false
		end,
	},
	keys = {
		-- Directional cursor add
		{
			"<C-j>",
			"<Cmd>MultipleCursorsAddDown<CR>",
			mode = { "n", "x" },
			desc = "Add cursor down",
		},
		{
			"<C-k>",
			"<Cmd>MultipleCursorsAddUp<CR>",
			mode = { "n", "x" },
			desc = "Add cursor up",
		},

		-- Mouse
		{
			"<C-LeftMouse>",
			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
			mode = { "n", "i" },
			desc = "Add or remove cursor",
		},

		-- Match-based
		{
			"<C-n>",
			"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and jump to next match",
		},
		{
			"<C-S-n>",
			"<Cmd>MultipleCursorsJumpNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Jump to next match",
		},

		-- Leader-v prefixed
		{
			"<Leader>va",
			"<Cmd>MultipleCursorsAddMatches<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to all matches",
		},
		{
			"<Leader>vA",
			"<Cmd>MultipleCursorsAddMatchesV<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to matches in visual area",
		},
		{
			"<Leader>vv",
			"<Cmd>MultipleCursorsAddVisualArea<CR>",
			mode = { "x" },
			desc = "Add cursors to visual area",
		},
		{
			"<Leader>vl",
			"<Cmd>MultipleCursorsLock<CR>",
			mode = { "n", "x" },
			desc = "Lock virtual cursors",
		},
	},
}
