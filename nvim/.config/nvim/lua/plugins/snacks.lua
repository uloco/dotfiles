return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		-- Track last used terminal count
		vim.g.snacks_last_terminal_count = 1

		-- Auto insert mode when entering terminal with mouse click
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*",
			callback = function()
				vim.keymap.set("n", "<LeftRelease>", "<LeftRelease>i", { buffer = true, desc = "Enter insert mode on mouse click" })
			end,
		})
	end,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true },
		bufdelete = { enabled = true },
		-- explorer = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = {
			enabled = true,
			args = {
				"--use-config-file=/Users/uloco/.config/lazygit/config-lazy.yml",
			},
			win = {
				position = "float",
				width = 0.85,
				height = 0.85,
			},
		},
		terminal = {
			enabled = true,
			win = {
				position = "right",
				width = 80,
			},
		},
		picker = {
			enabled = true,
			hidden = true,
			sources = {
				files = {
					hidden = true,
				},
				smart = {
					filter = {
						cwd = true,
						filter = function(item)
							-- Filter out files that no longer exist on disk
							if item.file then
								local path = item.file
								if not vim.startswith(path, "/") then
									path = vim.uv.cwd() .. "/" .. path
								end
								return vim.uv.fs_stat(path) ~= nil
							end
							return true
						end,
					},
				},
				-- 	explorer = {
				-- 		hidden = true,
				-- 		-- your explorer picker configuration comes here
				-- 		-- or leave it empty to use the default settings
				-- 	},
			},
			actions = {
				stopinsert = function(picker)
					picker.input:stopinsert()
				end,
			},
			win = {
				preview = {
					keys = {
						["<Esc>"] = { "focus_input", mode = { "n", "i" } },
						["q"] = "focus_input",
					},
				},
				input = {
					keys = {
						-- no way to enter normal mode
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<A-w>"] = { "cycle_win", mode = { "i", "n" } },
						["<A-e>"] = { "stopinsert", mode = { "i", "n" } },
						["<A-j>"] = { "history_forward", mode = { "i", "n" } },
						["<A-k>"] = { "history_back", mode = { "i", "n" } },
						["<A-q>"] = { "bufdelete", mode = { "i", "n" } },
						["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<C-S-d>"] = { "list_scroll_down", mode = { "i", "n" } },
						["<C-S-u>"] = { "list_scroll_up", mode = { "i", "n" } },
					},
					list = {
						keys = {
							["<A-j>"] = { "history_forward", mode = { "i", "n" } },
							["<A-k>"] = { "history_back", mode = { "i", "n" } },
							["<A-q>"] = { "bufdelete", mode = { "i", "n" } },
						},
					},
				},
			},
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = {
			enabled = true,
			foldopen = false,
		},
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
			input = {
				keys = { i_esc = { [2] = { "cmp_close", "<esc>" } } },
			},
			lazygit = {
				position = "float",
				border = "rounded",
				wo = {
					winhighlight = "Normal:Normal",
				},
			},
			terminal = {
				position = "right",
				width = 80,
				keys = {
					term_normal = false,
				},
			},
		},
	},
	keys = {
		{
			"<A-q>",
			function()
				Snacks.bufdelete.delete()
			end,
			mode = { "n", "i", "x", "t" },
			desc = "Delete Buffer",
		},
		{
			"<A-S-q>",
			function()
				Snacks.bufdelete.all()
			end,
			mode = { "n", "i", "x", "t" },
			desc = "Delete All Buffers",
		},
		{
			"<C-A-S-q>",
			function()
				Snacks.bufdelete.other()
			end,
			mode = { "n", "i", "x", "t" },
			desc = "Delete Other Buffers",
		},
		-- {
		-- 	"<leader>b",
		-- 	function()
		-- 		Snacks.explorer.open()
		-- 	end,
		-- 	desc = "Toggle Explorer",
		-- },
		-- {
		-- 	"<leader>ff",
		-- 	function()
		-- 		Snacks.explorer.reveal()
		-- 	end,
		-- 	desc = "Find File in Explorer",
		-- },
		{
			"©", -- right option + g
			function()
				Snacks.lazygit()
			end,
			mode = { "n", "t" },
			desc = "Lazygit",
		},
		{
			"<leader><leader>l",
			function()
				Snacks.picker()
			end,
			desc = "Open File Picker",
		},
		{
			"<leader>ll",
			function()
				Snacks.picker.smart()
			end,
			desc = "Open File Picker",
		},
		{
			"<leader>lL",
			function()
				Snacks.picker.files()
			end,
			desc = "Open File Picker",
		},
		{
			"<leader>lb",
			function()
				Snacks.picker.buffers()
				-- Snacks.picker.buffers({ focus = "list" })
			end,
			desc = "Open Buffer Picker",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>lf",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>lF",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>lp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>lh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>lH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},

		{
			"<leader>ln",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notifications",
		},
		{
			"<leader>lR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>ld",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"<leader>lD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"<leader>lr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"<leader>li",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"<leader>lt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"<leader>lo",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>lO",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<A-n>",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Jump to next word under cursor",
		},
		{
			"<A-S-n>",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Jump to previous word under cursor",
		},
		-- Terminal keymaps
		{
			"†", -- Alt-Gr + t
			function()
				-- Use explicit count if provided, otherwise use last used count
				local count = vim.v.count > 0 and vim.v.count or vim.g.snacks_last_terminal_count
				vim.g.snacks_last_terminal_count = count
				Snacks.terminal.toggle(nil, { count = count })
			end,
			mode = { "n", "t" },
			desc = "Toggle Terminal",
		},
		{
			"˝", -- Alt-Gr + Shift + t
			function()
				-- Filter to only split terminals (exclude floating ones)
				local terminals = vim.iter(Snacks.terminal.list()):filter(function(t)
					return not (t.opts and t.opts.win and t.opts.win.position == "float")
				end):totable()
				if #terminals == 0 then
					return
				end
				local any_visible = vim.iter(terminals):any(function(t)
					return t:win_valid()
				end)
				for _, term in ipairs(terminals) do
					if any_visible then
						term:hide()
					else
						term:show()
					end
				end
			end,
			mode = { "n", "t" },
			desc = "Toggle All Terminals",
		},
		{
			"ª", -- Alt + h
			function()
				Snacks.terminal.toggle(nil, {
					env = { SNACKS_FLOAT = "1" }, -- differentiate from split terminal
					win = { position = "float", border = "rounded", width = 0.85, height = 0.85 },
				})
			end,
			mode = { "n", "t" },
			desc = "Toggle Floating Terminal",
		},
		{
			"å", -- Alt + a
			function()
				require("sidekick.cli").toggle({ name = "opencode", focus = true })
			end,
			mode = { "n", "t" },
			desc = "Toggle Opencode (Sidekick)",
		},
	},
}
