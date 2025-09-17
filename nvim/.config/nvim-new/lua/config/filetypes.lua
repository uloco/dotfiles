vim.cmd([[
  let g:do_filetype_lua = 1
]])

vim.filetype.add({
	filename = {
		["Fastfile"] = "ruby",
		["Podfile"] = "ruby",
		[".eslintrc.json"] = "jsonc",
	},
	extension = {
		xml = "html",
		["code-snippets"] = "jsonc",
	},
})
