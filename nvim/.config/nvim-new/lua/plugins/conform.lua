return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>ö",
      function()
        require("conform").format()
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua", lsp_format = "prefer" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      css = { "prettierd" },
      less = { "prettierd" },
      scss = { "prettierd" },
      graphql = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      html = { "prettierd" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "beautysh" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      beautysh = {
        prepend_args = { "-i", "2" },
      }
    },
    -- init = function()
    --   -- If you want the formatexpr, here is the place to set it
    --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    -- end,
  }
}
