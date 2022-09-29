local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'bash',
    'typescript',
    'tsx',
    'javascript',
    'json',
    'css',
    'markdown',
    'lua',
    'make',
    'dockerfile',
    'gitattributes',
    'gitignore',
    'graphql',
    'html',
    'jsdoc',
    'php',
    'python',
    'ruby',
    'regex',
    'scss',
    'sql',
    'toml',
    'yaml',
    'vim',
    'swift',
  },
  autotag = {
    enable = true
  },
  context_commentstring = {
    enabled = true,
    enable_autocmd = false,
    config = {
      -- jsx comments
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
    }
  }
}
