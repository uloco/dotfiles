vim.cmd("autocmd!")

vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.smartindent = true
vim.opt.pumheight = 20
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 40
vim.opt.expandtab = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.showmode = false
vim.opt.jumpoptions = "view"

vim.opt.showbreak = "↪ "

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

-- folding
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "——→", multispace = "·", trail = "·", nbsp = "␣" }

-- disable swap files
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.wildoptions = "pum"
vim.opt.signcolumn = "yes"

vim.diagnostic.config({ float = { border = "rounded" } })
vim.o.winborder = "rounded"

-- don't show whitespace when diffing in neovim
-- vim.opt.diffopt:append({ "iwhite" })

vim.opt.timeout = false

-- Disable unused built-in plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
