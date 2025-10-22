local default_opts = { silent = true }
local function map(mode, lhs, rhs, user_opts)
	local opts = vim.tbl_extend("force", default_opts, user_opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

local keymap = vim.keymap

local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x', opts)

-- Increment/decrement
keymap.set({ "n" }, "+", "<C-a>", opts)
keymap.set({ "n" }, "-", "<C-x>", opts)
keymap.set({ "v" }, "+", "<C-a>gv", opts)
keymap.set({ "v" }, "-", "<C-x>gv", opts)
keymap.set({ "v" }, "<C-+>", "g<C-a>", opts)
keymap.set({ "v" }, "<C-S-+>", "g<C-x>", opts)

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d', opts)

-- Select all
keymap.set("n", "<A-a>", "ggVG", opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Split window
keymap.set("n", "sS", ":split<CR>", { silent = true })
keymap.set("n", "ss", ":vsplit<CR>", { silent = true })

-- Resize window
keymap.set("n", "<A-->", "10<C-w>>", opts)
keymap.set("n", "<A-S-->", "10<C-w><", opts)
keymap.set("n", "<A-S-ö>", "5<C-w>-", opts)
keymap.set("n", "<A-ö>", "5<C-w>+", opts)

-- reload lua file
keymap.set("n", "<leader>so", ":luafile %<CR>", opts)

-- save
keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader><leader>w", ":wa<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
-- save all and exit
keymap.set("n", "<leader><leader>q", "<cmd>wa<cr><cmd>qa<cr>", opts)

-- disable search highlighting
keymap.set("n", "<leader>hi", ":nohl<CR>", opts)

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
keymap.set("n", "<A-t>", "<cmd>tabnew<cr>", opts)

-- organize splits
keymap.set("n", "<A-0>", "<C-W><C-=>", opts)
keymap.set("n", "<A-S-0>", "<C-W><C-=>", opts)
-- goto previous split
keymap.set("n", "<A-p>", "<C-W><C-p>", opts)
keymap.set("t", "<A-p>", "<C-\\><C-n><C-W><C-p>", opts)

-- yank and paste from clipboard
keymap.set({ "n", "v" }, "<Leader>y", '"*y', opts)

-- paste in visual and keep in yank
keymap.set({ "x" }, "p", "pgvy", opts)

-- Terminal
keymap.set("t", "<A-e>", "<C-\\><C-n>", opts)

-- Center on half page up down
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", opts)
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", opts)

-- Center after next search
keymap.set({ "n", "v" }, "n", "nzz", opts)
keymap.set({ "n", "v" }, "N", "Nzz", opts)

-- TODO: remove this after adding vim-asterisk
-- Make * not jump after select word under cursor
keymap.set({ "n" }, "*", "m`<cmd>keepjumps normal! *``<cr>", opts)

-- multi cursor alternative (visual highlight first, better than * cgn)
vim.cmd([[nnoremap <leader>cw <cmd>let @/='\<'.expand('<cword>').'\>'<cr>"_ciw]])
vim.cmd([[xnoremap <leader>cw y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>"_cgn]])

-- Duplicate and comment
keymap.set({ "n" }, "<leader>gc", "mCyygccP`Ck", { remap = true, silent = true })
keymap.set({ "v" }, "<leader>gc", "YPmCgvgc`C", { remap = true, silent = true })

local conform = require("conform")
--format document
keymap.set({ "n" }, "<leader>ö", function()
	conform.format()
	-- vim.lsp.buf.format({
	--   async = false,
	--   -- Never request typescript-language-server for formatting
	--   filter = function(c) return c.name ~= "tsserver" end
	-- })
end)

-- show signature
keymap.set({ "n" }, "gH", vim.lsp.buf.signature_help)

-- open links / files
keymap.set("n", "gl", function()
	require("notify")("Use gx instead!", "warn")
end, opts)

-- Run @ macro on visual range selected lines
vim.cmd([[
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
]])

-- See highlight group
vim.keymap.set("n", "<C-S-P>", "<cmd>TSHighlightCapturesUnderCursor<cr>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Alternate buffer
vim.keymap.set({ "n", "i" }, "<A-o>", "<C-^>", { silent = true })
