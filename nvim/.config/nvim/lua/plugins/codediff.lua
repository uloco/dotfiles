return {
	{
		"esmuellert/codediff.nvim",
		opts = {
			explorer = {
				view_mode = "list",
			},
			keymaps = {
				view = {
					next_hunk = "<leader>jh",
					prev_hunk = "<leader>kh",
					next_file = "<leader>jf",
					prev_file = "<leader>kf",
					stage_hunk = "<leader>ha",
					unstage_hunk = "<leader>hu",
					discard_hunk = "<leader>hr",
					toggle_layout = "<leader>dl",
				},
				explorer = {
					stage_all = "<leader>hA",
					unstage_all = "<leader>hU",
					restore = "<leader>hR",
				},
				conflict = {
					accept_current = "<leader>co",
					accept_incoming = "<leader>ct",
					accept_both = "<leader>cb",
					discard = "<leader>cn",
					next_conflict = "<leader>jc",
					prev_conflict = "<leader>kc",
				},
			},
		},
		keys = {
			{ "<leader>df", "<cmd>CodeDiff<CR>", desc = "Toggle Diff" },
			{ "<leader>dh", "<cmd>CodeDiff history<CR>", desc = "File history" },
		},
		cmd = { "CodeDiff" },
	},
}
