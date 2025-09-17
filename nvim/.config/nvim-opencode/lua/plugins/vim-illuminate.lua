return {
	"RRethy/vim-illuminate",
	opts = {
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		delay = 200,
		filetype_overrides = {},
		filetypes_denylist = {
			"dirvish",
			"fugitive",
		},
		filetypes_allowlist = {},
		modes_denylist = {},
		modes_allowlist = {},
		providers_regex_syntax_denylist = {},
		providers_regex_syntax_allowlist = {},
		under_cursor = true,
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
		vim.keymap.set("n", "<A-n>", require("illuminate").goto_next_reference)
		vim.keymap.set("n", "<A-S-n>", require("illuminate").goto_prev_reference)
	end,
}
