return {
	"ojroques/nvim-bufdel",
	cmd = { "BufDel", "BufDelOther", "BufDelAll" },
	opts = {
		next = "tabs",
		quit = false,
	},
	config = function(_, opts)
		require("bufdel").setup(opts)
		local opt = { noremap = true, silent = true }
		vim.keymap.set({ "n", "i", "v", "t" }, "<A-q>", "<cmd>:BufDel<cr>", opt)
		vim.keymap.set({ "n", "i", "v", "t" }, "<A-S-q>", "<cmd>BufDelAll<cr>", opt)
		vim.keymap.set({ "n", "i", "v", "t" }, "<A-S-t>", "<cmd>BufDelOthers<cr>", opt)
	end,
}
