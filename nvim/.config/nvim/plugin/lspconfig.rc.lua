local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

lspconfig.graphql.setup {
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

lspconfig.lua_ls.setup {
  -- on_attach = on_attach,
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = "Enable",
        setType = true,
      },
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

local capabilitiesJson = vim.lsp.protocol.make_client_capabilities()
capabilitiesJson.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup {
  capabilities = capabilitiesJson,
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    }
  }
}

lspconfig.rust_analyzer.setup({})
lspconfig.tailwindcss.setup({})

-- lspconfig.emmet_language_server.setup({
--   filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
--   -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
--   -- **Note:** only the options listed in the table are supported.
--   init_options = {
--     ---@type table<string, string>
--     includeLanguages = {},
--     --- @type string[]
--     excludeLanguages = {},
--     --- @type string[]
--     extensionsPath = {},
--     --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
--     preferences = {},
--     --- @type boolean Defaults to `true`
--     showAbbreviationSuggestions = true,
--     --- @type "always" | "never" Defaults to `"always"`
--     showExpandedAbbreviation = "always",
--     --- @type boolean Defaults to `false`
--     showSuggestionsAsSnippets = false,
--     --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
--     syntaxProfiles = {},
--     --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
--     variables = {},
--   },
-- })
