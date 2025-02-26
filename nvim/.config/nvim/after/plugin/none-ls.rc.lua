local status, none_ls = pcall(require, "null-ls")
if (not status) then return end

---@diagnostic disable-next-line: redundant-parameter
none_ls.setup {
  sources = {
    none_ls.builtins.diagnostics.fish,
    require("none-ls.code_actions.eslint_d"),
    require("none-ls.diagnostics.eslint_d").with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    none_ls.builtins.formatting.prettierd
  },
}
