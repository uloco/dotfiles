return {
	"dnlhc/glance.nvim",
	cmd = "Glance",
	opts = { border = { enable = true } },
	keys = {
		{ "<leader>gd", "<CMD>Glance definitions<CR>", desc = "Glance Definitions" },
		{ "<leader>gt", "<CMD>Glance type_definitions<CR>", desc = "Glance Type Definitions" },
		{ "<leader>gr", "<CMD>Glance references<CR>", desc = "Glance References" },
		{ "<leader>gm", "<CMD>Glance implementations<CR>", desc = "Glance Implementations" },
	},
}
