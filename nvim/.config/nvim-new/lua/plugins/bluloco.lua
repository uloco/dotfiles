-- the colorscheme should be available when starting Neovim
return {
	"uloco/bluloco.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	dependencies = { "rktjmp/lush.nvim" },
	config = function()
		-- load the colorscheme here
		require("bluloco").setup({
			style = "auto",
			transparent = true,
			italics = false,
		})
		vim.cmd([[colorscheme bluloco]])
	end,
}
