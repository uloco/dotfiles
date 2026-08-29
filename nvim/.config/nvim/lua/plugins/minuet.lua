return {
	"milanglacier/minuet-ai.nvim",
	lazy = false,
	opts = {
		provider = "codestral",
		context_window = 16000,
		throttle = 500,
		debounce = 75,
		request_timeout = 3,
		notify = "warn",
		virtualtext = {
			auto_trigger_ft = { "*" },
			auto_trigger_ignore_ft = {
				"yaml",
				"markdown",
				"help",
				"gitcommit",
				"gitrebase",
				"hgcommit",
				"svn",
				"cvs",
			},
			keymap = {
				accept = "<C-l>",
				accept_line = false,
				accept_n_lines = false,
				prev = "<C-S-o>",
				next = "<C-o>",
				dismiss = "<A-e>",
			},
			show_on_completion_menu = true,
		},
		provider_options = {
			codestral = {
				api_key = "CODESTRAL_API_KEY",
				model = "codestral-latest",
				stream = true,
				optional = {
					max_tokens = 256,
				},
			},
		},
	},
	config = function(_, opts)
		require("minuet").setup(opts)

		-- fix getting out of sync
		local backend = require("minuet.backends." .. opts.provider)
		local complete = backend.complete
		backend.complete = function(context, callback)
			local buf = vim.api.nvim_get_current_buf()
			local tick = vim.api.nvim_buf_get_changedtick(buf)
			complete(context, function(data)
				if vim.api.nvim_get_current_buf() ~= buf then
					return
				end
				if vim.api.nvim_buf_get_changedtick(buf) ~= tick then
					return
				end
				callback(data)
			end)
		end
	end,
}
