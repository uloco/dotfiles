vim.opt.sessionoptions = {
	"blank",
	"buffers",
	"curdir",
	"folds",
	"help",
	"tabpages",
	"winsize",
	"winpos",
	"terminal",
	"localoptions",
	"globals",
}

return {
	"rmagatti/auto-session",
	event = "VimEnter",
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		log_level = "error",
		auto_session_suppress_dirs = { "~/", "~/Source", "~/Downloads", "/" },
		bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
		purge_after_minutes = 43200,
		legacy_cmds = false,
		-- cwd_change_handling = true,
		-- git_use_branch_name = true,
		-- git_auto_restore_on_branch_change = true,
		auto_restore = true,
		post_restore_cmds = {
			function()
				-- Trigger linting on the current buffer after session restore
				require("lint").try_lint()
			end,
		},
	},
	keys = {
		{ "<leader>lp", "<cmd>AutoSession search<cr>", desc = "Search Sessions" },
	},
}
