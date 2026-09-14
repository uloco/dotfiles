return {
	"folke/sidekick.nvim",
	dependencies = {
		-- "zbirenbaum/copilot.lua",
	},
	lazy = false,
	opts = {
		nes = {
			enabled = false,
			debounce = 100,
			diff = {
				inline = "words",
			},
		},
		cli = {
			watch = true,
			win = {
				layout = "float",
				keys = {
					-- disable default <c-f> file picker
					files = false,
					-- remap to option+f, refocus terminal on close
					files_alt = {
						"<a-f>",
						function(t)
							vim.cmd.stopinsert()
							vim.schedule(function()
								require("sidekick.cli.picker").open("files", { filter = { session = t.id } }, {
									on_show = function()
										t.normal_mode = false
									end,
									on_close = function()
										t:focus()
									end,
								})
							end)
						end,
						mode = "nt",
						desc = "open file picker",
					},
				},
			},
			mux = {
				enabled = false,
			},
			tools = {
				opencode = {
					cmd = { "opencode" },
					-- remap prompt to <a-p> so opencode's <c-p> commands menu works
					keys = { prompt = { "<a-p>", "prompt" } },
				},
				opencode2 = {
					cmd = { vim.fn.expand("~/.local/bin/opencode2") },
					is_proc = "\\<opencode2\\>",
					native_scroll = true,
					continue = { "--continue" },
					keys = { prompt = { "<a-p>", "prompt" } },
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
			"å", -- Alt + a
			function()
				require("config.floats").open("sidekick", function()
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end)
			end,
			mode = { "n", "t" },
			desc = "Toggle Opencode (Sidekick)",
		},
		{
			"Å", -- Alt+Shift+a
			function()
				require("config.floats").open("sidekick", function()
					require("sidekick.cli").toggle({ name = "opencode2", focus = true })
				end)
			end,
			mode = { "n", "t" },
			desc = "Toggle Opencode v2 (Sidekick)",
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
