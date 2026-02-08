return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "will-lynas/grapple-line.nvim" },
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "filetype" },
			lualine_y = { "lsp_status" },
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
		tabline = {},
		winbar = {
			lualine_a = { "filename" },
			lualine_b = {
				"filename",
				file_status = false,
				path = 2,
			},
			lualine_c = { "filename" },
		},
		inactive_winbar = {
			lualine_a = { "filename" },
		},
		extensions = {
			"mason",
			"nvim-tree",
			"quickfix",
			"lazy",
		},
	},
}
