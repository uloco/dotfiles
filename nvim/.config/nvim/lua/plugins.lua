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

  -- completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'onsails/lspkind-nvim' -- pictograms in completion

  use 'glepnir/lspsaga.nvim'

  use 'hrsh7th/nvim-cmp' -- Completion
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-comp source for neovim's built-in LSP
  use 'L3MON4D3/LuaSnip' -- Snippets

  -- utils
  use 'f-person/auto-dark-mode.nvim'
  use 'b3nj5m1n/kommentary'
  use({
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
  })
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'


end)
