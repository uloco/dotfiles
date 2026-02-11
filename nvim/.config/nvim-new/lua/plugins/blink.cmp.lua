return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets", "alexandre-abrioux/blink-cmp-npm.nvim" },
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
			["<C-j>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
			["<A-e>"] = { "hide" },
			["<Tab>"] = {
				"snippet_forward",
				function()
					return require("sidekick").nes_jump_or_apply()
				end,
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		signature = { enabled = true },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			list = { selection = { preselect = true, auto_insert = false } },
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "buffer" },
			providers = {
				npm = {
					name = "npm",
					module = "blink-cmp-npm",
					async = true,
					score_offset = 100,
					opts = {
						ignore = {},
						only_semantic_versions = true,
						only_latest_version = false,
					},
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = {
			keymap = {
				preset = "inherit",
				["<CR>"] = { "accept_and_enter", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			completion = {
				menu = { auto_show = true },
				list = { selection = { preselect = false, auto_insert = true } },
			},
		},
	},
	opts_extend = { "sources.default" },
}
