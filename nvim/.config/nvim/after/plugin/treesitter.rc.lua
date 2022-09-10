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
  }
}
