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
vim.opt.winbar = "%f"

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
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "——→", multispace = "·", trail = "·", nbsp = "␣" }

-- disable swap files
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.signcolumn = "yes"

vim.diagnostic.config({ virtual_text = true, float = { border = "rounded" } })

-- don't show whitespace when diffing in neovim
vim.opt.diffopt:append({ "iwhite" })

vim.opt.timeout = false
