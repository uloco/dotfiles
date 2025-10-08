return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		-- explorer = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = {
			enabled = true,
			-- delta pager does not work yet
			args = {
				"--use-config-file=/Users/uloco/.config/lazygit/config.yml",
			},
		},
		picker = {
			enabled = true,
			hidden = true,
			sources = {
				files = {
					hidden = true,
				},
				-- 	explorer = {
				-- 		hidden = true,
				-- 		-- your explorer picker configuration comes here
				-- 		-- or leave it empty to use the default settings
				-- 	},
			},
			filter = { cwd = true },
			actions = {
				stopinsert = function(picker)
					picker.input:stopinsert()
				end,
			},
			win = {
				input = {
					keys = {
						-- no way to enter normal mode
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<A-w>"] = "none",
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
			"<A-S-o>",
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
				Snacks.picker.buffers({ focus = "list" })
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
	},
}
