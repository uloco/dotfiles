local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- common utilities

  -- theme
  use 'folke/tokyonight.nvim'
  use 'Shatur/neovim-ayu'

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
  -- Lua
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
  -- package manager
  use 'williamboman/mason.nvim' -- easier lsp language install
  use 'williamboman/mason-lspconfig.nvim'

  -- prettier
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  -- utils
  use 'f-person/auto-dark-mode.nvim'
  use 'b3nj5m1n/kommentary'
  use({
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
  })
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- git
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'dinhhuy258/git.nvim'

  -- indent lines
  use "lukas-reineke/indent-blankline.nvim"

  -- column line
  -- init.lua
  use "lukas-reineke/virt-column.nvim"

  -- show what keys do
  use {
    'folke/which-key.nvim',
    disabled = true
  }

  -- better terminals
  use { "akinsho/toggleterm.nvim", tag = '*' }
end)
