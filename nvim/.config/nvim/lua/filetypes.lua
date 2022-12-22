vim.cmd [[
  let g:do_filetype_lua = 1
]]

vim.filetype.add({
  filename = {
    ["Fastfile"] = "ruby",
    ["Podfile"] = "ruby"
  },
  extension = {
    xml = 'html'
  }
})
