return {
	"rmagatti/auto-session",
	opts = {
		log_level = "error",
		auto_session_suppress_dirs = { "~/", "~/Source", "~/Downloads", "/" },
		pre_save_cmds = {
			function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local config = vim.api.nvim_win_get_config(win)
					if config.relative ~= "" then
						vim.api.nvim_win_close(win, false)
					end
				end
			end,
		},
	},
	config = function(_, opts)
		require("auto-session").setup(opts)
		vim.keymap.set({ "n" }, "<leader>lp", "<cmd>SessionSearch<cr>")
	end,
}
