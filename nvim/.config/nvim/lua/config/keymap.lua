local default_opts = { silent = true }
local function map(mode, lhs, rhs, user_opts)
	local opts = vim.tbl_extend("force", default_opts, user_opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Delete character without yanking
map("n", "x", '"_x', { desc = "Delete character without yanking" })

-- Increment/decrement
map({ "n" }, "+", "<C-a>", { desc = "Increment number under cursor" })
map({ "n" }, "-", "<C-x>", { desc = "Decrement number under cursor" })
map({ "v" }, "+", "<C-a>gv", { desc = "Increment numbers in selection" })
map({ "v" }, "-", "<C-x>gv", { desc = "Decrement numbers in selection" })
map({ "v" }, "<C-+>", "g<C-a>", { desc = "Increment all numbers in selection" })
map({ "v" }, "<C-S-+>", "g<C-x>", { desc = "Decrement all numbers in selection" })

-- Select all
map("n", "<A-a>", "ggVG", { desc = "Select all text" })

-- Split window
map("n", "sS", ":split<CR>", { desc = "Horizontal split" })
map("n", "ss", ":vsplit<CR>", { desc = "Vertical split" })

-- Resize window
map("n", "<A-->", "10<C-w>>", { desc = "Increase window width" })
map("n", "<A-S-->", "10<C-w><", { desc = "Decrease window width" })
map("n", "<A-S-ö>", "5<C-w>-", { desc = "Decrease window height" })
map("n", "<A-ö>", "5<C-w>+", { desc = "Increase window height" })

-- reload lua file
map("n", "<leader>so", ":luafile %<CR>", { desc = "Reload current Lua file" })

-- save
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader><leader>w", ":wa<CR>", { desc = "Save all files" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
map("n", "<leader><leader>q", "<cmd>wa<cr><cmd>qa<cr>", { desc = "Save all and quit" })

-- disable search highlighting
map("n", "<leader>hi", ":nohl<CR>", { desc = "Disable search highlighting" })

-- Open Lazy.nvim UI
map("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy UI" })

-- Split nav
map({ "n", "i", "t" }, "<A-j>", "<cmd>stopinsert<cr><C-W>j", { desc = "Move to split below" })
map({ "n", "i", "t" }, "<A-k>", "<cmd>stopinsert<cr><C-W>k", { desc = "Move to split above" })
map({ "n", "i", "t" }, "<A-l>", "<cmd>stopinsert<cr><C-W>l", { desc = "Move to split right" })
map({ "n", "i", "t" }, "<A-h>", "<cmd>stopinsert<cr><C-W>h", { desc = "Move to split left" })
map({ "n", "i", "t" }, "<A-S-j>", "<cmd>stopinsert<cr><C-W>J", { desc = "Move split to bottom" })
map({ "n", "i", "t" }, "<A-S-k>", "<cmd>stopinsert<cr><C-W>K", { desc = "Move split to top" })
map({ "n", "i", "t" }, "<A-S-l>", "<cmd>stopinsert<cr><C-W>L", { desc = "Move split to right" })
map({ "n", "i", "t" }, "<A-S-h>", "<cmd>stopinsert<cr><C-W>H", { desc = "Move split to left" })
map({ "n", "i" }, "<A-S-o>", "<C-w>x", { desc = "Swap current split with previous split" })

-- new Tab
map("n", "<A-t>", "<cmd>tabnew<cr>", { desc = "Open new tab" })

-- organize splits
map("n", "<A-0>", "<C-W><C-=>", { desc = "Equalize split sizes" })
map("n", "<A-S-0>", "<C-W><C-=>", { desc = "Equalize split sizes" })

-- goto previous split
map("n", "<A-p>", "<C-W><C-p>", { desc = "Go to previous split" })
map("t", "<A-p>", "<C-\\><C-n><C-W><C-p>", { desc = "Go to previous split (terminal)" })

-- Alternate buffer
map({ "n", "i" }, "<A-o>", "<C-6>", { desc = "Switch to alternate buffer" })
-- Buffers
map("n", "<A-i>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<A-u>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- yank and paste from clipboard
map({ "n", "v" }, "<Leader>y", '"*y', { desc = "Yank to system clipboard" })

-- paste in visual and keep in yank
map({ "x" }, "p", "pgvy", { desc = "Paste and keep selection yanked" })

-- Terminal
map({ "i", "t" }, "<A-e>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Center on half page up down
map({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Half page up and center" })

-- Center after next search
map({ "n", "v" }, "n", "nzz", { desc = "Next search result and center" })
map({ "n", "v" }, "N", "Nzz", { desc = "Previous search result and center" })

-- Enhanced search with lasterisk (vim-asterisk in lua)
-- * for whole word search, g* for partial word search
map({ "n" }, "*", function()
	require("utils.lasterisk").search({ silent = true })
end, { desc = "Search word under cursor (whole word)" })

map({ "n", "x" }, "g*", function()
	require("utils.lasterisk").search({ is_whole = false, silent = true })
end, { desc = "Search word under cursor (partial match)" })

-- Duplicate and comment
map({ "n" }, "<leader>gc", "mcyygccP`ck", { remap = true, desc = "Duplicate and comment line" })
map({ "v" }, "<leader>gc", "YPmcgvgc`c", { remap = true, desc = "Duplicate and comment selection" })

-- show signature
map({ "n" }, "gH", vim.lsp.buf.signature_help, { desc = "Show LSP signature help" })

-- Run @ macro on visual range selected lines
vim.cmd([[xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction]])

map({ "n", "v" }, "<Space>", "<Nop>", { desc = "Disable space key" })
