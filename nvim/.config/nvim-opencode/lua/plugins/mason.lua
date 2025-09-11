return {
  "williamboman/mason.nvim",
  config = function()
  local mason = require("mason")
  local lspconfig = require("mason-lspconfig")
  mason.setup({})
  lspconfig.setup {
    ensure_installed = { "lua_ls" },
    automatic_enable= false
  }
  require('mason-tool-installer').setup {
    ensure_installed = {
      "eslint_d",
      "graphql-language-service-cli",
      "lua-language-server",
      "markdownlint",
      "prettierd",
      "python-lsp-server",
      "shfmt",
      "stylua",
      "beautysh",
      "bash-language-server",
      "svelte-language-server",
      "typescript-language-server",
      "yaml-language-server",
      "json-lsp"
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 5,
  }
end,
}
