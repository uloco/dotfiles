return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"cbochs/grapple.nvim",
		{ dir = "~/source/neovim/lualine-grapple.nvim" },
	},
	opts = {
		options = {
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			always_show_tabline = false,
			disabled_filetypes = {
				winbar = { "sidekick_terminal" },
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "grapple_tags" },
			lualine_x = { "filetype" },
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
				},
			},
			lualine_c = {
				-- only file path
				{
					function()
						return vim.fn.expand("%:.:h")
					end,
				},
				"diagnostics",
			},
			lualine_x = { "diff" },
		},
		inactive_winbar = {
			lualine_b = {
				"filename",
			},
			lualine_c = {
				-- only file path
				function()
					return vim.fn.expand("%:.:h")
				end,
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
