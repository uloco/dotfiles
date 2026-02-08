return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "will-lynas/grapple-line.nvim" },
	opts = {
		options = {
			globalstatus = true,
		},
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
			lualine_b = {
				{
					"filename",
					separator = { left = "", right = "" },
					color = { fg = "@tag" },
				},
			},
			lualine_c = {
				-- only file path
				function()
					return vim.fn.expand("%:.:h")
				end,
			},
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
