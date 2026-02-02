return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	opts = {
		view = {
			adaptive_size = true,
			number = true,
			relativenumber = true,
		},
	},
	keys = {
		{ "<leader>b", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree" },
		{ "<leader>ff", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Nvim Tree" },
	},
}
