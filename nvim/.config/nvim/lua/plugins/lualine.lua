-- Hide lualine winbar inside codediff panes. codediff sets
-- `w:codediff_restore = 1` on its diff windows; we use that as the marker.
-- Without this, lualine's per-window winbar swap on focus changes causes
-- the diff panes to visibly jump.
local function not_codediff()
	local win = vim.g.statusline_winid or vim.api.nvim_get_current_win()
	return vim.w[win].codediff_restore == nil
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"cbochs/grapple.nvim",
		{ dir = "~/source/neovim/lualine-grapple.nvim" },
		"AndreM222/copilot-lualine",
	},
	opts = {
		options = {
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			always_show_tabline = false,
			disabled_filetypes = {
				winbar = { "sidekick_terminal", "snacks_terminal" },
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "grapple_tags" },
			lualine_x = { { "copilot", show_colors = true }, "filetype" },
			lualine_y = { "lsp_status", "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_z = {
				{
					"tabs",
					show_modified_status = false,
				},
			},
		},
		winbar = {
			lualine_b = {
				{
					"filename",
					color = { fg = "@tag" },
					cond = not_codediff,
				},
			},
			lualine_c = {
				{
					function()
						return vim.fn.expand("%:.:h")
					end,
					cond = not_codediff,
				},
				{ "diagnostics", cond = not_codediff },
			},
			lualine_x = {
				{ "diff", cond = not_codediff },
			},
		},
		inactive_winbar = {
			lualine_b = {
				{
				  "filename",
				  cond = not_codediff
				},
			},
			lualine_c = {
				{
					function()
						return vim.fn.expand("%:.:h")
					end,
					cond = not_codediff,
				},
			},
		},
		extensions = {
			"mason",
			"nvim-tree",
			"quickfix",
			"lazy",
		},
	},
}
