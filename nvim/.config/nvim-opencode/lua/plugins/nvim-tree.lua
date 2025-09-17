return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		view = {
			adaptive_size = true,
			number = true,
			relativenumber = true,
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		vim.keymap.set("n", "<leader>b", "<cmd>NvimTreeToggle<cr>")
		vim.keymap.set("n", "<leader>ff", "<cmd>NvimTreeFindFile<cr>")
	end,
}
