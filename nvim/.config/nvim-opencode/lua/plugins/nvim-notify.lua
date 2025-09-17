return {
	"rcarriga/nvim-notify",
	opts = {
		level = 3,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
