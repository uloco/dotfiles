-- lsp rename
vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
			-- save all open buffrs after rename
			vim.cmd("wall")
		end
	end,
})

return {
	"stevearc/oil.nvim",
	enabled = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		float = {
			max_width = 0.5,
			win_options = {
				winblend = 15,
			},
		},
		keys = {
			["<C-c>"] = "actions.close",
			-- ["<C-d>"] = "actions.preview_scroll_down",
			-- ["<C-u>"] = "actions.preview_scroll_up",
		},
	},
	dependencies = { "nvim-mini/mini.nvim" },
	lazy = false,
	keys = {
		{ "<leader>fb", "<cmd>Oil --float %:p:h<cr>", desc = "Open Oil" },
	},
}
