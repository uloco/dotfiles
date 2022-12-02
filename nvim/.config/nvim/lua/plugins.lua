local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- common utilities
  use '~/Source/neovim/bluloco.nvim'

  -- theme
  use { 'folke/tokyonight.nvim', commit = '1d1d1722e035389dc3bfc2489133fa58533c310f' }

  -- statusbar bottom
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- semantic highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  -- quick find
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- tabs
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- close buffers like vscode tabs
  use 'ojroques/nvim-bufdel'

  -- colorize hex values
  use 'norcalli/nvim-colorizer.lua'

  -- scroll bar
  use 'petertriho/nvim-scrollbar'

  -- todo comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  -- error and todo panel
  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  --lsp
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim' -- pictograms in completion
  use 'glepnir/lspsaga.nvim' -- vscode like peeks, refactorings

  -- completion
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-comp source for neovim's built-in LSP
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'L3MON4D3/LuaSnip' -- Snippets
  use 'saadparwaiz1/cmp_luasnip'
  use 'David-Kunz/cmp-npm'

  -- package manager
  use 'williamboman/mason.nvim' -- easier lsp language install
  use 'williamboman/mason-lspconfig.nvim'

  -- prettier
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  -- utils
  use 'f-person/auto-dark-mode.nvim'
  use 'b3nj5m1n/kommentary'
  use 'kylechui/nvim-surround'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- git
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use { 'akinsho/git-conflict.nvim', tag = "*", }

  -- indent lines
  use "lukas-reineke/indent-blankline.nvim"

  -- column line
  use "lukas-reineke/virt-column.nvim"

  -- show what keys do
  use {
    'folke/which-key.nvim',
    disabled = true
  }

  -- better terminals
  use "akinsho/toggleterm.nvim"

  -- greeter
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- session management
  use 'rmagatti/auto-session'

  -- highltight word under cursor
  use 'RRethy/vim-illuminate'

  -- better folding
  use 'anuvyklack/pretty-fold.nvim'

  -- comments in mixed languages like tsx
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- new stuff for flight, probably not configured or tested yet
  use 'rktjmp/lush.nvim'
  use 'nvim-treesitter/playground'
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    requires = { "kkharji/sqlite.lua" }
  }
  use 'windwp/nvim-spectre'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- tree explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- notifications pop up messages
  use 'rcarriga/nvim-notify'

  -- semantic paramenter highlighting
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    "smjonas/live-command.nvim",
    -- tag = "1.*",
    sha = "5d1b0c0e8278542d65cd992775b4f3bd8a287fb6",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
          Glob = { cmd = "g" },
        }
      }
    end,
  }


end)
