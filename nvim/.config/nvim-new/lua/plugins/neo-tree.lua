return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.nvim",
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			default_component_configs = {
				icon = {
					-- use mini.icons
					provider = function(icon, node) -- setup a custom icon provider
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then -- if it's a file, set the text/hl
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then -- get directory icons
							text, hl = mini_icons.get("directory", node.name)
							-- only set the icon text if it is not expanded
							if node:is_expanded() then
								text = nil
							end
						end

						-- set the icon text/highlight only if it exists
						if text then
							icon.text = text
						end
						if hl then
							icon.highlight = hl
						end
					end,
				},
				kind_icon = {
					provider = function(icon, node)
						local mini_icons = require("mini.icons")
						icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
					end,
				},
			},
			window = {
				mappings = {
					-- ["<space>"] = {
					-- 	"toggle_node",
					-- 	nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
					-- },
					-- ["<leader>b"] = "close_window",
				},
			},
			filesystem = {
				window = {
					mappings = {
						["-"] = "navigate_up",
						["<bs>"] = "close_node",
					},
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
		},
		keys = {
			{ "<leader>b", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
			-- { "<leader>bb", "<cmd>Neotree buffers<cr>", desc = "Toggle NeoTree" },
			{ "<leader>ff", "<cmd>Neotree reveal<cr>", desc = "Find File in NeoTree" },
		},
	},
}
