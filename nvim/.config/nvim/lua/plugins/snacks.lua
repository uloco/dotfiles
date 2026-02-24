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
				macros = {
				title = "Saved Macros",
				finder = function(opts, ctx)
					local macros_util = require("utils.macros")
					local macros = macros_util.load()
					local items = {}
					for i, m in ipairs(macros) do
						items[#items + 1] = {
							text = m.name .. " " .. m.description,
							item = m,
							macro_idx = i,
						}
					end
					return items
				end,
				format = function(item)
					local m = item.item
					local highlights = {
						{ " ", "Special" },
						{ m.name, "Title" },
					}
					if m.description ~= "" then
						highlights[#highlights + 1] = { "  " .. m.description, "Comment" }
					end
					highlights[#highlights + 1] = { "  @" .. m.register, "Number" }
					return highlights
				end,
				preview = function(ctx)
					local macros_util = require("utils.macros")
					local state = ctx.preview.state

					-- Lazy capture of buffer context on first preview call
					if not state.original_lines then
						if state.source_buf and vim.api.nvim_buf_is_valid(state.source_buf) then
							state.original_lines = vim.api.nvim_buf_get_lines(state.source_buf, 0, -1, false)
							state.ft = vim.bo[state.source_buf].filetype
						else
							state.original_lines = {}
							state.ft = ""
						end
						if state.source_win and vim.api.nvim_win_is_valid(state.source_win) then
							state.cursor = vim.api.nvim_win_get_cursor(state.source_win)
						else
							state.cursor = { 1, 0 }
						end
					end

					if not ctx.item or not ctx.item.item then
						return
					end

					local macro = ctx.item.item

					-- If buffer is empty, show static info
					if #state.original_lines == 0 or (#state.original_lines == 1 and state.original_lines[1] == "") then
						ctx.preview:reset()
						ctx.preview:set_lines({
							"No buffer content to preview against",
							"",
							"Name:        " .. macro.name,
							"Description: " .. (macro.description ~= "" and macro.description or "(none)"),
							"Register:    @" .. macro.register,
							"Keystrokes:  " .. macros_util.format_keys(macro.keys),
						})
						return
					end

					-- Compute diff
					local new_lines, err = macros_util.compute_diff(state.original_lines, macro.keys, state.cursor)

					if not new_lines then
						ctx.preview:reset()
						ctx.preview:set_lines({
							"Error executing macro:",
							err or "unknown error",
							"",
							"Keystrokes: " .. macros_util.format_keys(macro.keys),
						})
						return
					end

					local diff_result = macros_util.build_preview(state.original_lines, new_lines)

					if not diff_result.has_changes then
						ctx.preview:reset()
						ctx.preview:set_lines({
							"No changes on current buffer",
							"",
							"Keystrokes: " .. macros_util.format_keys(macro.keys),
						})
						return
					end

					-- Compute fold ranges (folds unchanged gaps for large buffers
					-- or when there are multiple non-adjacent change regions)
					local display = macros_util.scope_preview(diff_result)

					-- Render
					ctx.preview:reset()
					ctx.preview:set_lines(display.lines)
					ctx.preview:highlight({ ft = state.ft })

					-- Apply diff highlights via extmarks
					local ns = vim.api.nvim_create_namespace("macros_preview")
					for _, hl in ipairs(display.highlights) do
						pcall(vim.api.nvim_buf_set_extmark, ctx.buf, ns, hl.line, hl.col_start, {
							end_col = hl.col_end,
							hl_group = hl.hl_group,
							priority = 200, -- higher than syntax highlighting
						})
					end

					-- Apply folds on unchanged regions
					if #display.fold_ranges > 0 then
						ctx.preview:wo({
							foldenable = true,
							foldmethod = "manual",
							foldlevel = 0, -- start with folds closed
						})
						vim.api.nvim_win_call(ctx.win, function()
							-- Clear any existing folds first
							vim.cmd("normal! zE")
							for _, range in ipairs(display.fold_ranges) do
								-- fold command uses 1-indexed lines
								vim.cmd(string.format("%d,%dfold", range[1] + 1, range[2] + 1))
							end
						end)
					else
						-- No folds needed — disable folding
						ctx.preview:wo({
							foldenable = false,
						})
					end
				end,
				confirm = function(picker, item)
					if not item then
						return
					end
					picker:close()
					local macros_util = require("utils.macros")
					macros_util.execute(item.item.keys)
				end,
				actions = {
					macro_delete = function(picker)
						local item = picker:current()
						if not item then
							return
						end
						local macros_util = require("utils.macros")
						macros_util.delete(item.macro_idx)
						picker:find()
					end,
					macro_yank = function(picker)
						local item = picker:current()
						if not item then
							return
						end
						local macros_util = require("utils.macros")
						macros_util.load_to_register(item.item.keys, item.item.register)
					end,
				},
				win = {
					input = {
						keys = {
							["<C-x>"] = { "macro_delete", mode = { "i", "n" }, desc = "Delete macro" },
							["<C-y>"] = { "macro_yank", mode = { "i", "n" }, desc = "Load to register" },
						},
					},
				},
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
			"<leader>lm",
			function()
				local buf = vim.api.nvim_get_current_buf()
				local win = vim.api.nvim_get_current_win()
				Snacks.picker.pick("macros", {
					on_show = function(picker)
						picker.preview.state.source_buf = buf
						picker.preview.state.source_win = win
					end,
				})
			end,
			desc = "Saved Macros",
		},
		{
			"<leader>ms",
			function()
				require("utils.macros").save_macro()
			end,
			desc = "Save Macro from Register",
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
					return t.opts.position ~= "float"
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
