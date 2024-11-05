vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

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
vim.opt.shell = 'zsh'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.showmode = false
vim.opt.jumpoptions = 'view'

-- winbar
vim.opt.winbar='%f'

vim.opt.wrap = true
vim.opt.showbreak = '↪ '
-- vim.opt.wrapmargin = 0

vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Disable auto comments on next line
local augroup_format_options = vim.api.nvim_create_augroup("Format-Options", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup_format_options,
  callback = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end
})

-- @uloco
vim.g.mapleader = " "

-- autocmd
vim.opt.smartcase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.config/nvim/.vimundo')
vim.opt.mouse = 'a'
vim.opt.termguicolors = true

-- highlight yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

-- folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '——→', multispace = '·', trail = '·', nbsp = '␣' }

-- disable swap files
vim.opt.swapfile = false
