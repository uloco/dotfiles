return {
  "petertriho/nvim-scrollbar",
  config = function(_, opts)
  local scrollbar = require('scrollbar')
  scrollbar.setup()
  require("scrollbar.handlers.gitsigns").setup()
end,
}
