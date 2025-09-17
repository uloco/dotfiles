return {
	"akinsho/bufferline.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	opts = {
		options = {
			indicator = {
				style = "underline",
			},
			themable = true,
			mode = "buffers",
			always_show_bufferline = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		local opt = { noremap = true, silent = true }
		vim.keymap.set("n", "<A-i>", "<cmd>BufferLineCycleNext<cr>", opt)
		vim.keymap.set("n", "<A-u>", "<cmd>BufferLineCyclePrev<cr>", opt)
		vim.keymap.set("n", "<A-S-i>", "<cmd>BufferLineMoveNext<cr>", opt)
		vim.keymap.set("n", "<A-S-u>", "<cmd>BufferLineMovePrev<cr>", opt)
		vim.keymap.set("n", "<Leader>gt", ":BufferLinePick<cr>", opt)
	end,
}
