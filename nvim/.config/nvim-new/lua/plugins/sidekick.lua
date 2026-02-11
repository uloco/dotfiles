return {
	"folke/sidekick.nvim",
	dependencies = {
		"zbirenbaum/copilot.lua",
	},
	opts = {
		nes = {
			debounce = 100,
			diff = {
				inline = "words",
			},
		},
		cli = {
			watch = true,
			win = {
				layout = "float",
			},
			mux = {
				enabled = false,
			},
			tools = {
				opencode = {
					cmd = { "opencode" },
				},
			},
		},
	},
	keys = {
		{
			"<tab>",
			function()
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>"
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select()
			end,
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This to CLI",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File to CLI",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection to CLI",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		{
			"<leader>an",
			function()
				require("sidekick.nes").toggle()
			end,
			desc = "Toggle NES",
		},
		{
			"<leader>ax",
			function()
				require("sidekick.nes").clear()
			end,
			desc = "Clear NES",
		},
	},
}
