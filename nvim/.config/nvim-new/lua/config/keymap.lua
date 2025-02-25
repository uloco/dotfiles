local keymap = vim.keymap

local opts = { noremap = true, silent = true }

keymap.set('n', 'x', '"_x', opts)

-- Increment/decrement
keymap.set({ 'n' }, '+', '<C-a>', opts)
keymap.set({ 'n' }, '-', '<C-x>', opts)
keymap.set({ 'v' }, '+', '<C-a>gv', opts)
keymap.set({ 'v' }, '-', '<C-x>gv', opts)
keymap.set({ 'v' }, '<C-+>', 'g<C-a>', opts)
keymap.set({ 'v' }, '<C-S-+>', 'g<C-x>', opts)

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d', opts)

-- Select all
keymap.set('n', '<A-a>', 'ggVG', opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Split window
keymap.set('n', 'sS', ':split<CR>', { silent = true })
keymap.set('n', 'ss', ':vsplit<CR>', { silent = true })

-- Resize window
keymap.set('n', '<A-->', '10<C-w>>', opts)
keymap.set('n', '<A-S-->', '10<C-w><', opts)
keymap.set('n', '<A-S-ö>', '5<C-w>-', opts)
keymap.set('n', '<A-ö>', '5<C-w>+', opts)

-- reload lua file
keymap.set('n', '<leader>so', ':luafile %<CR>', opts)

-- save
keymap.set('n', '<leader>w', ':w<CR>', opts)
keymap.set('n', '<leader><leader>w', ':wa<CR>', opts)
keymap.set('n', '<leader>q', ':q<CR>', opts)
-- save all and exit
keymap.set('n', '<leader><leader>q', '<cmd>wa<cr><cmd>qa<cr>', opts)

-- disable search highlighting
keymap.set('n', '<leader>hi', ':nohl<CR>', opts)

-- Split nav
keymap.set('n', '<A-j>', '<C-W><C-J>', opts)
keymap.set('n', '<A-k>', '<C-W><C-K>', opts)
keymap.set('n', '<A-l>', '<C-W><C-L>', opts)
keymap.set('n', '<A-h>', '<C-W><C-H>', opts)
keymap.set('n', '<A-S-j>', '<C-W>J', opts)
keymap.set('n', '<A-S-k>', '<C-W>K', opts)
keymap.set('n', '<A-S-l>', '<C-W>L', opts)
keymap.set('n', '<A-S-h>', '<C-W>H', opts)
keymap.set('i', '<A-j>', '<Esc><C-W><C-J>', opts)
keymap.set('i', '<A-k>', '<Esc><C-W><C-K>', opts)
keymap.set('i', '<A-l>', '<Esc><C-W><C-L>', opts)
keymap.set('i', '<A-h>', '<Esc><C-W><C-H>', opts)
keymap.set('t', '<A-j>', '<C-\\><C-n><C-W><C-J>', opts)
keymap.set('t', '<A-k>', '<C-\\><C-n><C-W><C-K>', opts)
keymap.set('t', '<A-l>', '<C-\\><C-n><C-W><C-L>', opts)
keymap.set('t', '<A-h>', '<C-\\><C-n><C-W><C-H>', opts)

-- new Tab
keymap.set('n', '<A-t>', '<cmd>tabnew<cr>', opts)

-- organize splits
keymap.set('n', '<A-0>', '<C-W><C-=>', opts)
keymap.set('n', '<A-S-0>', '<C-W><C-=>', opts)
-- goto previous split
keymap.set('n', '<A-p>', '<C-W><C-p>', opts)
keymap.set('t', '<A-p>', '<C-\\><C-n><C-W><C-p>', opts)

-- yank and paste from clipboard
keymap.set({ 'n', 'v' }, '<Leader>y', '"*y', opts)

-- paste in visual and keep in yank
keymap.set({ 'x' }, 'p', 'pgvy', opts)

-- Terminal
keymap.set('t', '<A-e>', '<C-\\><C-n>', opts)

-- Center on half page up down
-- keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', opts)
-- keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', opts)

-- Center after next search
-- keymap.set({ 'n', 'v' }, 'n', 'nzz', opts)
-- keymap.set({ 'n', 'v' }, 'N', 'Nzz', opts)

-- TODO: remove this after adding vim-asterisk
-- Make * not jump after select word under cursor
keymap.set({ 'n' }, '*', 'm`<cmd>keepjumps normal! *``<cr>', opts)

-- multi cursor alternative (visual highlight first, better than * cgn)
vim.cmd [[nnoremap <leader>cw <cmd>let @/='\<'.expand('<cword>').'\>'<cr>"_ciw]]
vim.cmd [[xnoremap <leader>cw y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>"_cgn]]

-- Duplicate and comment
keymap.set({ 'n' }, '<leader>gc', 'mCyygccP`Ck', { remap = true, silent = true })
keymap.set({ 'v' }, '<leader>gc', 'YPmCgvgc`C', { remap = true, silent = true })

-- show signature
keymap.set({ 'n' }, 'gH', vim.lsp.buf.signature_help)

-- Run @ macro on visual range selected lines
vim.cmd([[
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
]])

-- See highlight group
vim.keymap.set('n', '<C-S-P>', '<cmd>TSHighlightCapturesUnderCursor<cr>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Alternate buffer
vim.keymap.set({ 'n', 'i' }, '<A-o>', '<C-6>', { silent = true })
