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

local capabilitiesJson = vim.lsp.protocol.make_client_capabilities()
capabilitiesJson.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.jsonls.setup {
  capabilities = capabilitiesJson,
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = {
        -- Schemas https://www.schemastore.org
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
          url = 'http://json.schemastore.org/tsconfig'
        },
        {
          description = 'Lerna config',
          fileMatch = { 'lerna.json' },
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'Babel configuration',
          fileMatch = { '.babelrc.json', '.babelrc', 'babel.config.json' },
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'ESLint config',
          fileMatch = { '.eslintrc.json', '.eslintrc' },
          url = 'http://json.schemastore.org/eslintrc'
        },
        {
          description = 'Bucklescript config',
          fileMatch = { 'bsconfig.json' },
          url = 'https://bucklescript.github.io/bucklescript/docson/build-schema.json'
        },
        {
          description = 'Prettier config',
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'http://json.schemastore.org/prettierrc'
        },
        {
          description = 'Vercel Now config',
          fileMatch = { 'now.json' },
          url = 'http://json.schemastore.org/now'
        },
        {
          description = 'Stylelint config',
          fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' },
          url = 'http://json.schemastore.org/stylelintrc'
        },
        {
          description = "Npm package config",
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json"
        },
      }
    }
  }
}
