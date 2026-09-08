vim.cmd([[
  let g:do_filetype_lua = 1
]])

vim.filetype.add({
	filename = {
		["Fastfile"] = "ruby",
		["Podfile"] = "ruby",
		[".eslintrc.json"] = "jsonc",
		[".zsh.env"] = "zsh",
	},
	extension = {
		xml = "html",
		podspec = "ruby",
		["code-snippets"] = "jsonc",
	},
})
