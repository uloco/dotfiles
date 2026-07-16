return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		hide_numbers = false,
		open_mapping = "†", -- Alt-Gr + t
		insert_mappings = true,
		start_in_insert = true,
		persist_mode = false,
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

		-- Re-enter insert on lazygit / sidekick overlays when returning from the
		-- floating terminal. Deferred to run after the plugin's own mode handling.
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			group = vim.api.nvim_create_augroup("Term-Insert", { clear = true }),
			callback = function()
				local ft = vim.bo.filetype
				if ft == "snacks_terminal" or ft == "sidekick_terminal" then
					local win = vim.api.nvim_get_current_win()
					vim.defer_fn(function()
						if vim.api.nvim_get_current_win() == win and vim.fn.mode() ~= "t" then
							vim.cmd("startinsert")
						end
					end, 20)
				end
			end,
		})
	end,
}
