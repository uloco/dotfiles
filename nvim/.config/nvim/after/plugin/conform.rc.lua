local status, conform = pcall(require, "conform")
if not status then
  return
end

conform.setup({
  formatters_by_ft = {
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
})
