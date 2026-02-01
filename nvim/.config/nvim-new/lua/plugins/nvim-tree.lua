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
	config = function(plugin, opts)
		require("nvim-tree").setup(opts)
		-- rename file handler
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
	end,
	keys = {
		{ "<leader>b", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree" },
		{ "<leader>ff", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Nvim Tree" },
	},
}
