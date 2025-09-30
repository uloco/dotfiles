return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.nvim",
		},
		enabled = true,
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
					["/"] = "none", -- disable fuzzy filter
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
					enabled = false, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(arg)
						vim.cmd([[
          setlocal number
          setlocal relativenumber
          ]])
					end,
				},
			},
		},
		config = function(_, opts)
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end
			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
			require("neo-tree").setup(opts)
		end,
		keys = {
			{ "<leader>b", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
			{ "<leader>B", "<cmd>Neotree buffers<cr>", desc = "Toggle NeoTree" },
			{ "<leader>ff", "<cmd>Neotree reveal<cr>", desc = "Find File in NeoTree" },
		},
	},
}
