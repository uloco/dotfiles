---Ensure custom lualine grapple highlights exist
local function ensure_grapple_highlights()
	local punct_fg = vim.api.nvim_get_hl(0, { name = "Punctuation", link = false }).fg
	local number_fg = vim.api.nvim_get_hl(0, { name = "Number", link = false }).fg

	for _, suffix in ipairs({ "lualine_c_normal", "Folded" }) do
		local bg = vim.api.nvim_get_hl(0, { name = suffix, link = false }).bg
		local tag = suffix == "Folded" and "Active" or ""
		if punct_fg then
			vim.api.nvim_set_hl(0, "GrapplePunctuation" .. tag, { fg = punct_fg, bg = bg })
		end
		if number_fg then
			vim.api.nvim_set_hl(0, "GrappleNumber" .. tag, { fg = number_fg, bg = bg })
		end
	end
end

---Create a lualine component for a grapple tag slot
---@param index number
---@return table
local function grapple_tag(index)
	return {
		function()
			local grapple = require("grapple")
			if not grapple.exists({ index = index }) then
				return ""
			end
			local tag = grapple.find({ index = index })
			local name = vim.fn.fnamemodify(tag.path, ":t")

			ensure_grapple_highlights()

			local function hl(group)
				return "%#" .. group .. "#"
			end

			local current_path = vim.api.nvim_buf_get_name(0)
			local is_active = tag.path == current_path
			local suffix = is_active and "Active" or ""
			local name_hl = is_active and "Folded" or "lualine_c_normal"

			return hl("GrapplePunctuation" .. suffix)
				.. "["
				.. hl("GrappleNumber" .. suffix)
				.. index
				.. hl("GrapplePunctuation" .. suffix)
				.. "]"
				.. hl(name_hl)
				.. " "
				.. name
		end,
		cond = function()
			return package.loaded["grapple"] and require("grapple").exists({ index = index })
		end,

		on_click = function()
			require("grapple").select({ index = index })
		end,
	}
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"cbochs/grapple.nvim",
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
			lualine_c = { "%=", grapple_tag(1), grapple_tag(2), grapple_tag(3), grapple_tag(4) },
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
			-- lualine_a = { {
			-- 	"buffers",
			-- 	separator = { right = "", left = "" },
			-- } },
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
					separator = { left = "", right = "" },
					color = { fg = "@tag" },
				},
			},
			lualine_c = {
				-- only file path
				function()
					return vim.fn.expand("%:.:h")
				end,
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
