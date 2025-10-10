local auto_dark_mode = require("auto-dark-mode")

local function isAuto()
	return require("bluloco").config.style == "auto"
end

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		if isAuto() then
			vim.o.background = "dark"
		end
	end,
	set_light_mode = function()
		if isAuto() then
			vim.o.background = "light"
		end
	end,
})
