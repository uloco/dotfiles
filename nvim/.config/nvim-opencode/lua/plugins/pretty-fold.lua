return {
  "bbjornstad/pretty-fold.nvim",
  opts = {
    fill_char = '\u2014'
  },
  config = function(_, opts)
    require('pretty-fold').setup(opts)
  end,
}
