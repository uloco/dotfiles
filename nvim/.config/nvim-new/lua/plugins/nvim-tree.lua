local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
vim.api.nvim_create_autocmd("User", {
	pattern = "NvimTreeSetup",
	callback = function()
		local events = require("nvim-tree.api").events
		events.subscribe(events.Event.NodeRenamed, function(data)
			if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
				data = data
				Snacks.rename.on_rename_file(data.old_name, data.new_name)
			end
		end)
	end,
})

return {
	"nvim-tree/nvim-tree.lua",
  enabled = true,
	opts = {
		view = {
			adaptive_size = true,
			number = true,
			relativenumber = true,
		},
	},
	lazy = false,
	keys = {
		{ "<leader>b", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		{ "<leader>ff", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in NvimTree" },
	},
}
