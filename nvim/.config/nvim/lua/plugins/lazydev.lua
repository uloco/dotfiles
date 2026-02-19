return {
  "folke/lazydev.nvim",
  event = "VeryLazy",
  config = function()
    require("lazydev").setup({
      -- Optional: specify the path to your Neovim configuration directory
      config_path = vim.fn.stdpath("config"),
    })
  end,
}
