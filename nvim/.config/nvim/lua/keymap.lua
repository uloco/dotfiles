local keymap = vim.keymap


local opts = { noremap = true, silent = true }

keymap.set('n', 'x', '"_x', opts)

-- Increment/decrement
keymap.set('n', '+', '<C-a>', opts)
keymap.set('n', '-', '<C-x>', opts)

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d', opts)

-- Select all
keymap.set('n', '<C-a>', 'ggVG', opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Split window
keymap.set('n', 'sS', ':split<CR>', { silent = true })
keymap.set('n', 'ss', ':vsplit<CR>', { silent = true })

-- Resize window
keymap.set('n', '<A-S-Left>', '10<C-w><', opts)
keymap.set('n', '<A-S-Right>', '10<C-w>>', opts)
keymap.set('n', '<A-S-Up>', '10<C-w>+', opts)
keymap.set('n', '<A-S-Down>', '20<C-w>-', opts)

-- reload lua file
keymap.set('n', '<leader>so', ':luafile %<CR>', opts)

-- save
keymap.set('n', '<leader>w', ':w<CR>', opts)
keymap.set('n', '<leader><leader>w', ':wa<CR>', opts)
keymap.set('n', '<leader>q', ':q<CR>', opt)
-- save all and exit
keymap.set('n', '<leader><leader>q', '<cmd>wa<cr><cmd>qa<cr>', opts)

-- disable search highlighting
keymap.set('n', '<leader>hi', ':nohl<CR>', opts)

-- Split nav
keymap.set('n', '<A-j>', '<C-W><C-J>', opts)
keymap.set('n', '<A-k>', '<C-W><C-K>', opts)
keymap.set('n', '<A-l>', '<C-W><C-L>', opts)
keymap.set('n', '<A-h>', '<C-W><C-H>', opts)
keymap.set('n', '<A-J>', '<C-W>J', opts)
keymap.set('n', '<A-K>', '<C-W>K', opts)
keymap.set('n', '<A-L>', '<C-W>L', opts)
keymap.set('n', '<A-H>', '<C-W>H', opts)
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
keymap.set('n', '<A-=>', '<C-W><C-=>', opts)
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
keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', opts)
keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', opts)
keymap.set({ 'n', 'v' }, 'n', 'nzz', opts)
keymap.set({ 'n', 'v' }, 'N', 'Nzz', opts)

-- TODO: remove this after adding vim-asterisk
-- Make * not jump after select word under cursor
keymap.set({ 'n' }, '*', 'm`<cmd>keepjumps normal! *``<cr>', opts)

-- multi cursor alternative
vim.cmd [[nnoremap <leader>cw <cmd>let @/='\<'.expand('<cword>').'\>'<cr>"_ciw]]
vim.cmd [[xnoremap <leader>cw y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>"_cgn]]


-- Duplicate and comment
keymap.set({ 'n' }, '<leader>gc', 'mCyy<Plug>kommentary_line_default<cr>P`Cj', opts)
keymap.set({ 'v' }, '<leader>gc', 'YPmCgv<Plug>kommentary_visual_default<cr>`C<esc>', opts)

--format document
keymap.set({ 'n' }, '<leader>l', function() vim.lsp.buf.format() end)

-- show signature
keymap.set({ 'n' }, 'gH', vim.lsp.buf.signature_help)

-- open links / files
keymap.set('n', 'gl', [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

-- Run @ macro on visual range selected lines
vim.cmd([[
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
]])

-- Auto insert mode when entering terminal
local augroup_term_insert = vim.api.nvim_create_augroup("Term-Insert", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
  group = augroup_term_insert,
  pattern = 'term://*',
  command = 'startinsert'
})

-- See highlight group
vim.keymap.set('n', '<C-S-P>', '<cmd>TSHighlightCapturesUnderCursor<cr>')

--[[
" Enter insert mode when entering terminal
" autocmd BufWinEnter,WinEnter term://* startinsert

" Change current working directory to file location
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>tcd :call <SID>ChangeTabDir()<CR>
function! <SID>ChangeTabDir()
  let s:cwd = getcwd()
  execute "tcd" . s:cwd
  execute "pwd"
endfunc


" Switch between different file extensions
map <A-u> :e %:r.ts <CR>
map <A-i> :e %:r.scss <CR>
map <A-o> :e %:r.html <CR>
map <A-d> :e %:r.spec.ts <CR>

]]


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
