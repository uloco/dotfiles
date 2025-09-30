return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()
	end,
}
