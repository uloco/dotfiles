local status, auto_session = pcall(require, "auto-session")
if not status then
	return
end

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

auto_session.setup({
	log_level = "error",
	auto_session_suppress_dirs = { "~/", "~/Source", "~/Downloads", "/" },
	bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
	purge_after_minutes = 43200,
	legacy_cmds = false,
	pre_save_cmds = {
		"ScopeSaveState",
	},
	post_restore_cmds = { "ScopeLoadState" },

	-- cwd_change_handling = true,
	-- git_use_branch_name = true,
	-- git_auto_restore_on_branch_change = true,
})

vim.keymap.set({ "n" }, "<leader>lp", "<cmd>AutoSession search<cr>")
