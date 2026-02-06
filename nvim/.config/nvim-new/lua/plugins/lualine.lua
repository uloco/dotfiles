return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	keys = {
		{ "<Leader>1", "<cmd>LualineBuffersJump! 1<cr>", desc = "Jump to buffer 1" },
		{ "<Leader>2", "<cmd>LualineBuffersJump! 2<cr>", desc = "Jump to buffer 2" },
		{ "<Leader>3", "<cmd>LualineBuffersJump! 3<cr>", desc = "Jump to buffer 3" },
		{ "<Leader>4", "<cmd>LualineBuffersJump! 4<cr>", desc = "Jump to buffer 4" },
		{ "<Leader>5", "<cmd>LualineBuffersJump! 5<cr>", desc = "Jump to buffer 5" },
		{ "<Leader>6", "<cmd>LualineBuffersJump! 6<cr>", desc = "Jump to buffer 6" },
		{ "<Leader>7", "<cmd>LualineBuffersJump! 7<cr>", desc = "Jump to buffer 7" },
		{ "<Leader>8", "<cmd>LualineBuffersJump! 8<cr>", desc = "Jump to buffer 8" },
		{ "<Leader>9", "<cmd>LualineBuffersJump! 9<cr>", desc = "Jump to buffer 9" },
	},
	opts = {
		options = {
			globalstatus = true,
			icons_enabled = true,
			theme = "auto",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 0,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
				},
				"encoding",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					show_filename_only = true,
					hide_filename_extension = false,
					show_modified_status = true,
					mode = 2, -- show buffer name + buffer index
					max_length = vim.o.columns,
					symbols = {
						modified = " ●",
						alternate_file = "",
						directory = "",
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "tabs" },
		},
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1, -- relative path
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "nvim-tree", "lazy", "mason", "quickfix" },
	},
}
