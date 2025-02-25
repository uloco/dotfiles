local status, none_ls = pcall(require, "none-ls")
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

---@diagnostic disable-next-line: redundant-parameter
none_ls.setup {
  sources = {
    none_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    none_ls.builtins.diagnostics.fish,
        none_ls.builtins.code_actions.eslint_d,
    -- none_ls.builtins.formatting.beautysh.with({
    --   extra_args = { '-i', '2' }
    -- }),
    none_ls.builtins.formatting.prettierd
  },
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      --   -- auto format
      --   vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     group = augroup_format,
      --     buffer = 0,
      --     callback = function()
      --       vim.lsp.buf.format({
      --         async = false,
      --         -- Never request typescript-language-server for formatting
      --         filter = function(c) return c.name ~= "tsserver" end
      --       })
      --     end
      --   })
    end
  end,

}
