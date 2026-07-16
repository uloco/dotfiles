return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		hide_numbers = false,
		open_mapping = "†", -- Alt-Gr + t
		insert_mappings = true,
		terminal_mappings = true,
		direction = "vertical",
		size = 80,
		autochdir = true, -- when neovim changes its current directory the terminal will change its own when next it's opened
		float_opts = {
			border = "curved",
			winblend = 0,
		},
		persist_size = false,
		winbar = {
			enabled = true,
		},
		auto_scroll = false,
		close_on_exit = true,
	},
	keys = {
		-- Alt-Gr + shift + t
		{ "˝", "<cmd>ToggleTermToggleAll<cr>", mode = { "n", "t" }, desc = "Toggle All Terminals" },
		-- right option + h -> floating terminal
		{
			"ª",
			function()
				local float = require("toggleterm.terminal").Terminal:new({
					id = 101,
					cmd = "zsh",
					hidden = true,
					direction = "float",
				})
				if float:is_open() then
					-- same key pressed while visible -> toggle it off
					float:close()
				else
					-- open, then hide the other overlays once it is on screen
					require("config.floats").open("toggleterm", function()
						float:open()
					end)
				end
			end,
			mode = { "n", "t" },
			desc = "Toggle Floating Terminal",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Auto insert mode when entering a toggleterm terminal
		local augroup_term_insert = vim.api.nvim_create_augroup("Term-Insert", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
			group = augroup_term_insert,
			pattern = "term://*",
			callback = function()
				-- sidekick manages its own insert mode, so leave it alone here
				if vim.bo.filetype ~= "sidekick_terminal" then
					vim.cmd("startinsert")
				end
			end,
		})

		-- Re-enter insert mode when returning to the lazygit / sidekick overlays
		-- (e.g. after toggling to the floating terminal and back).
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			group = augroup_term_insert,
			callback = function()
				local ft = vim.bo.filetype
				if ft == "snacks_terminal" or ft == "sidekick_terminal" then
					-- defer so we win the race with the plugin's own focus handling
					vim.schedule(function()
						if vim.api.nvim_get_mode().mode ~= "t" and vim.bo.filetype == ft then
							vim.cmd("startinsert")
						end
					end)
				end
			end,
		})

		-- Auto insert mode when entering terminal with mouse click
		local augroup_term_insert_mouse = vim.api.nvim_create_augroup("Term-Insert-Mouse", { clear = true })
		vim.api.nvim_create_autocmd({ "TermOpen" }, {
			group = augroup_term_insert_mouse,
			pattern = "*",
			command = "nnoremap <buffer><LeftRelease> <LeftRelease>i",
		})
	end,
}
