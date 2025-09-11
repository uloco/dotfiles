return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  -- lazy = false,
  event = { "VeryLazy" },
  -- event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<C-S-P>",
      "<cmd>Inspect<cr>",
      mode = "n",
      desc = "Highlight Capture",
    },
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>",      desc = "Decrement Selection", mode = "x" },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
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
      -- 'swift',
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
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
