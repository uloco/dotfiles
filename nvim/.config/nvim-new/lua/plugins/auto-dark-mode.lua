return {
	"f-person/auto-dark-mode.nvim",
	opts = {
		update_interval = 1000,
		set_dark_mode = function()
			if require("bluloco").config.style == "auto" then
				vim.o.background = "dark"
			end
		end,
		set_light_mode = function()
			if require("bluloco").config.style == "auto" then
				vim.o.background = "light"
			end
		end,
	},
}
