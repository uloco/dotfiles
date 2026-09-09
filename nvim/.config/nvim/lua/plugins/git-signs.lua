return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 200,
		},
		numhl = true,
		current_line_blame_formatter = "     <author>, <author_time:%Y-%m-%d> - <summary>",
	},
	keys = {
		{ "<leader>ub", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Git Blame" },
		{ "<leader>kh", ":Gitsigns prev_hunk<CR>zz", desc = "Previous Git Hunk" },
		{ "<leader>jh", ":Gitsigns next_hunk<CR>zz", desc = "Next Git Hunk" },
		{ "<leader>ha", ":Gitsigns stage_hunk<cr>", desc = "Stage Git Hunk", mode = { "n", "v" } },
		{ "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", desc = "Undo Stage Git Hunk" },
		{ "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset Git Hunk", mode = { "n", "v" } },
		{ "<leader>hp", ":Gitsigns preview_hunk<CR>", desc = "Preview Git Hunk" },
		{ "<leader>hA", ":Gitsigns stage_buffer<CR>", desc = "Stage Git Buffer" },
		{ "<leader>hR", ":Gitsigns reset_buffer<CR>", desc = "Reset Git Buffer" },
	},
}
