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
map("n", "<A-j>", "<C-W><C-J>", { desc = "Move to split below" })
map("n", "<A-k>", "<C-W><C-K>", { desc = "Move to split above" })
map("n", "<A-l>", "<C-W><C-L>", { desc = "Move to split right" })
map("n", "<A-h>", "<C-W><C-H>", { desc = "Move to split left" })
map("n", "<A-S-j>", "<C-W>J", { desc = "Move split to bottom" })
map("n", "<A-S-k>", "<C-W>K", { desc = "Move split to top" })
map("n", "<A-S-l>", "<C-W>L", { desc = "Move split to right" })
map("n", "<A-S-h>", "<C-W>H", { desc = "Move split to left" })
map("i", "<A-j>", "<Esc><C-W><C-J>", { desc = "Move to split below (insert)" })
map("i", "<A-k>", "<Esc><C-W><C-K>", { desc = "Move to split above (insert)" })
map("i", "<A-l>", "<Esc><C-W><C-L>", { desc = "Move to split right (insert)" })
map("i", "<A-h>", "<Esc><C-W><C-H>", { desc = "Move to split left (insert)" })
map("t", "<A-j>", "<C-\\><C-n><C-W><C-J>", { desc = "Move to split below (terminal)" })
map("t", "<A-k>", "<C-\\><C-n><C-W><C-K>", { desc = "Move to split above (terminal)" })
map("t", "<A-l>", "<C-\\><C-n><C-W><C-L>", { desc = "Move to split right (terminal)" })
map("t", "<A-h>", "<C-\\><C-n><C-W><C-H>", { desc = "Move to split left (terminal)" })

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

-- Make * not jump after select word under cursor
map({ "n" }, "*", "m`<cmd>keepjumps normal! *``<cr>", { desc = "Search word under cursor without jumping" })

-- Duplicate and comment
map({ "n" }, "<leader>gc", "mCyygccP`Ck", { remap = true, desc = "Duplicate and comment line" })
map({ "v" }, "<leader>gc", "YPmCgvgc`C", { remap = true, desc = "Duplicate and comment selection" })

-- show signature
map({ "n" }, "gH", vim.lsp.buf.signature_help, { desc = "Show LSP signature help" })

-- Run @ macro on visual range selected lines
vim.cmd([[xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction]])

map({ "n", "v" }, "<Space>", "<Nop>", { desc = "Disable space key" })
