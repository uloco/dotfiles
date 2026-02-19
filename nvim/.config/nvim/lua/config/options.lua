vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.pumheight = 20
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.showmode = false
vim.opt.jumpoptions = "view"

-- winbar
-- vim.opt.winbar = "%t %#Comment#%{expand('%:.:h')}%*"

vim.opt.wrap = true
vim.opt.showbreak = "↪ "
-- vim.opt.wrapmargin = 0

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.smartcase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("$HOME/.config/nvim/.vimundo")
vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- folding
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "——→", multispace = "·", trail = "·", nbsp = "␣" }

-- disable swap files
vim.opt.swapfile = false

-- spell checking (treesitter-aware: only checks comments/strings in code files)
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.opt.spelloptions = { "camel" }

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.signcolumn = "yes"

vim.diagnostic.config({ float = { border = "rounded" } })
vim.o.winborder = "rounded"

-- don't show whitespace when diffing in neovim
-- vim.opt.diffopt:append({ "iwhite" })

vim.opt.timeout = false
vim.o.winborder = "rounded"

-- Disable unused built-in plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
