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
				require("toggleterm.terminal").Terminal
					:new({ id = 101, cmd = "zsh", hidden = true, direction = "float" })
					:toggle()
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
				local bufname = vim.api.nvim_buf_get_name(0)
				local filetype = vim.bo.filetype
				-- Exclude sidekick / ai terminals by buffer name or filetype
				if not (bufname:match(":sidekick") or filetype == "sidekick_terminal") then
					vim.cmd("startinsert")
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
