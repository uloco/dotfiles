return {
  "RRethy/vim-illuminate",
  opts = {
    filetypes_denylist = {
      "snacks_terminal",
      "sidekick_terminal",
    },
  },
  keys = {
    {
      "<A-n>",
      function()
        require("illuminate").goto_next_reference()
      end,
      desc = "Jump to next reference",
    },
    {
      "<A-S-n>",
      function()
        require("illuminate").goto_prev_reference()
      end,
      desc = "Jump to previous reference",
    },
  },
}
