---Override separators for all components
---@param sections table
---@return table
local function process_sections(sections)
	for _, section in pairs(sections) do
		for id, comp in ipairs(section) do
			if type(comp) ~= "table" then
				comp = { comp }
				section[id] = comp
			end
			comp.component_separators = { left = "", right = "" }
			comp.section_separators = { left = "", right = "" }
		end
	end
	return sections
end

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
			component_separators = "",
			section_separators = { left = "", right = "" },
			always_show_tabline = false,
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "branch" },
			lualine_c = { "%=", { "grapple_tags" } },
			lualine_x = { "filetype" },
			lualine_y = { "lsp_status", "progress" },
			lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
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
			lualine_y = {},
			lualine_z = {
				{
					"tabs",
					mode = 2,
					show_modified_status = false,
					separator = { right = "", left = "" },
				},
			},
		},
		winbar = {
			lualine_b = {
				{
					"filename",
					separator = { right = "", left = "" },
					color = { fg = "@tag" },
				},
			},
			lualine_c = {
				-- only file path
				{
					function()
						return vim.fn.expand("%:.:h")
					end,
					separator = { right = "", left = "" },
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
	config = function(_, opts)
		-- NOTE: Modify separators before loading plugin
		opts.tabline = process_sections(opts.tabline)
		require("lualine").setup(opts)
	end,
}
