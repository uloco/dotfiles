local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

---@diagnostic disable-next-line: missing-fields
ts.setup {
  highlight = {
    enable = true,
    disable = { "markdown" }
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
    'java',
    'elixir',
    'json',
    'jsonc',
    'css',
    'lua',
    'make',
    'dockerfile',
    'gitattributes',
    'gitignore',
    'graphql',
    'groovy',
    'html',
    'jsdoc',
    -- 'php',
    'python',
    'ruby',
    'regex',
    'scss',
    'toml',
    'yaml',
    'vim',
    'vimdoc',
    'swift',
    'svelte',
    'rust',
    'r',
    'go',
    'cpp',
    'sql',
    'kotlin',
    'dart',
    'scala',
    'haskell',
    'erlang',
    -- 'help',
    'markdown',
    'markdown_inline',
    'objc',
    'ini'
  },
  textobjects = {
    select = {
      enable = true,

      -- -- Automatically jump forward to textobj, similar to targets.vim
      -- lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
  },
}
