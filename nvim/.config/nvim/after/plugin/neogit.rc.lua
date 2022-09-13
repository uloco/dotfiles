local neogit = require("neogit")

neogit.setup {
  kind = "floating",
  commit_popup = {
    kind = "floating",
  },
  popup = {
    kind = "floating",
  },
  integrations = {
    diffview = true
  },
  disable_commit_confirmation = true
}

vim.keymap.set('n', '<Leader>gc', function()
  neogit.open({ "commit" })
end
)

vim.keymap.set('n', '<Leader>gp', function()
  neogit.open({ "push" })
end
)

vim.keymap.set('n', '<Leader>gg', function()
  neogit.open()
end
)
