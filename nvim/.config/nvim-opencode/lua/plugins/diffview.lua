return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	config = function(_, opts)
		local actions = require("diffview.actions")

		require("diffview").setup({
			enhanced_diff_hl = true,
			file_panel = {
				listing_style = "list",
			},
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
			keymaps = {
				disable_defaults = false,
				view = {
					["gf"] = actions.goto_file,
					["<leader>e"] = actions.focus_files,
					["<leader>db"] = actions.toggle_files,
					["<leader>dl"] = actions.cycle_layout,
					["<leader>kc"] = actions.prev_conflict,
					["<leader>jc"] = actions.next_conflict,
					["<leader>co"] = actions.conflict_choose("ours"),
					["<leader>ct"] = actions.conflict_choose("theirs"),
					["<leader>cb"] = actions.conflict_choose("base"),
					["<leader>ca"] = actions.conflict_choose("all"),
					["<leader>cx"] = actions.conflict_choose("none"),
				},
				diff3 = {
					{ { "n", "x" }, "2do", actions.diffget("ours") },
					{ { "n", "x" }, "3do", actions.diffget("theirs") },
				},
				diff4 = {
					{ { "n", "x" }, "1do", actions.diffget("base") },
					{ { "n", "x" }, "2do", actions.diffget("ours") },
					{ { "n", "x" }, "3do", actions.diffget("theirs") },
				},
				file_panel = {
					["-"] = actions.toggle_stage_entry,
					["S"] = actions.stage_all,
					["U"] = actions.unstage_all,
					["X"] = actions.restore_entry,
					["R"] = actions.refresh_files,
					["L"] = actions.open_commit_log,
					["<c-u>"] = actions.scroll_view(-0.25),
					["<c-d>"] = actions.scroll_view(0.25),
					["gf"] = actions.goto_file,
					["i"] = actions.listing_style,
					["f"] = actions.toggle_flatten_dirs,
					["<leader>e"] = actions.focus_files,
					["<leader>b"] = actions.toggle_files,
					["<leader>kc"] = actions.prev_conflict,
					["<leader>jc"] = actions.next_conflict,
				},
				file_history_panel = {
					["g?"] = actions.options,
					["<C-A-d>"] = actions.open_in_diffview,
					["y"] = actions.copy_hash,
					["L"] = actions.open_commit_log,
					["zR"] = actions.open_all_folds,
					["zM"] = actions.close_all_folds,
					["<c-u>"] = actions.scroll_view(-0.25),
					["<c-d>"] = actions.scroll_view(0.25),
					["gf"] = actions.goto_file,
					["<leader>e"] = actions.focus_files,
					["<leader>b"] = actions.toggle_files,
				},
				option_panel = {
					["<tab>"] = actions.select_entry,
					["q"] = actions.close,
				},
			},
		})
		local function DiffviewToggle()
			local lib = require("diffview.lib")
			local view = lib.get_current_view()
			if view then
				vim.cmd(":DiffviewClose")
			else
				vim.cmd(":DiffviewOpen")
			end
		end
		local function DiffviewHistoryToggle(file)
			local lib = require("diffview.lib")
			local view = lib.get_current_view()
			if view then
				vim.cmd(":DiffviewClose")
			elseif file then
				vim.cmd(":DiffviewFileHistory %")
			else
				vim.cmd(":DiffviewFileHistory")
			end
		end
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>df", function()
			DiffviewToggle()
		end, opts)
		vim.keymap.set("n", "<leader>dh", function()
			DiffviewHistoryToggle(true)
		end, opts)
		vim.keymap.set("n", "<leader>dH", function()
			DiffviewHistoryToggle(false)
		end, opts)
	end,
}
