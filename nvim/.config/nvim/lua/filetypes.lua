vim.cmd [[
  let g:do_filetype_lua = 1
]]

vim.filetype.add({
  filename = {
    ["Fastfile"] = "ruby",
    ["Podfile"] = "ruby",
    [".eslintrc.json"] = "jsonc",
    [".code-snippets"] = "jsonc",
  },
  extension = {
    xml = 'html'
  }
})
