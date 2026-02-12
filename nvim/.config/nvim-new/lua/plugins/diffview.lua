return {
	{
		"sindrets/diffview.nvim",
		config = function()
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
					view = {
						["<leader>dl"] = actions.cycle_layout,
						["<leader>kc"] = actions.prev_conflict,
						["<leader>jc"] = actions.next_conflict,
						["<leader>cx"] = actions.conflict_choose("none"),
					},
					file_panel = {
						["<c-u>"] = actions.scroll_view(-0.25),
						["<c-d>"] = actions.scroll_view(0.25),
						["<leader>kc"] = actions.prev_conflict,
						["<leader>jc"] = actions.next_conflict,
					},
					file_history_panel = {
						["<c-u>"] = actions.scroll_view(-0.25),
						["<c-d>"] = actions.scroll_view(0.25),
					},
				},
			})
		end,
		keys = {
			{
				"<leader>df",
				function()
					local view = require("diffview.lib").get_current_view()
					if view then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewOpen")
					end
				end,
				desc = "Toggle Diffview",
			},
			{
				"<leader>dh",
				function()
					local view = require("diffview.lib").get_current_view()
					if view then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewFileHistory %")
					end
				end,
				desc = "File history (current file)",
			},
			{
				"<leader>dh",
				":'<,'>DiffviewFileHistory<CR>",
				mode = "v",
				desc = "Line history (selection)",
			},
			{
				"<leader>dH",
				function()
					local view = require("diffview.lib").get_current_view()
					if view then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewFileHistory")
					end
				end,
				desc = "File history (all commits)",
			},
		},
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	},
}
