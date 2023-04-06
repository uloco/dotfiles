local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

nvim_lsp.graphql.setup {
  on_attach = function(client)
    client.server_capabilities.workspaceSymbolProvider = false
  end,
  filetypes = {
    "graphql",
    "typescriptreact",
    "typescript",
    "javascript",
    "javascriptreact"
  },
}

nvim_lsp.lua_ls.setup {
  -- on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      }
    }
  }
}
