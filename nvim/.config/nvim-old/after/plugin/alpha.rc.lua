local status, alpha = pcall(require, "alpha")
if not status then
	return
end

local themes = require("alpha.themes.startify")

alpha.setup(themes.config)
