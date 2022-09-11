local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<M-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Split window
keymap.set('n', 'ss', ':split<CR>', { silent = true })
keymap.set('n', 'sv', ':vsplit<CR>', { silent = true })

-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')


-- @uloco

-- keymap.set('n', '<leader>so',  ':so '..vim.fn.expand('$HOME/.config/nvim/init.lua')..'<CR>')
keymap.set('n', '<Leader>so', ':luafile %<CR>')
keymap.set('n', '<Leader>w', ':w<CR>')
-- keymap.set('n', '<Leader>q', ':q<CR>')
keymap.set('n', '<Leader>hi', ':nohl<CR>')

-- Split nav (trying takuyas approach for now)
-- keymap.set('n',  '<A-j>', '<C-W><C-J>')
-- keymap.set('n',  '<A-k>', '<C-W><C-K>')
-- keymap.set('n',  '<A-l>', '<C-W><C-L>')
-- keymap.set('n',  '<A-h>', '<C-W><C-H>')

-- yank and paste from clipboard
keymap.set({ 'n', 'v' }, '<Leader>y', '"*y')

-- paste without
keymap.set({ 'x' }, '<Leader>p', '"_dP')

-- Terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Center on half page up down
keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')

-- Make * not jump after select word under cursor
keymap.set({ 'n' }, '*', 'm`<cmd>keepjumps normal! *``<cr>')

-- Duplicate and comment TODO
keymap.set({ 'v' }, '<Leader>gc', 'gc')

-- "after": ["m", "~", "Y", "g", "c", "c", "p", "`", "~", "j"]


--[[
" New Tab with ctrl-w + t
nnoremap <A-t> :tabnew<CR>

" Terminal Mode Mappings
tnoremap <Esc> <C-\><C-n>

" Enter insert mode when entering terminal
" autocmd BufWinEnter,WinEnter term://* startinsert

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <leader>hi :nohlsearch<CR>

" Change current working directory to file location
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>tcd :call <SID>ChangeTabDir()<CR>
function! <SID>ChangeTabDir()
  let s:cwd = getcwd()
  execute "tcd" . s:cwd
  execute "pwd"
endfunc


" Reload .vimrc file
nnoremap <leader>so :so ~/.vimrc<CR>

" Often used shortcuts
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>a :wa<CR>

" Split nav
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
inoremap <A-j> <Esc><C-W><C-J>
inoremap <A-k> <Esc><C-W><C-K>
inoremap <A-l> <Esc><C-W><C-L>
inoremap <A-h> <Esc><C-W><C-H>
tnoremap <A-j> <C-\><C-n><C-W><C-J>
tnoremap <A-k> <C-\><C-n><C-W><C-K>
tnoremap <A-l> <C-\><C-n><C-W><C-L>
tnoremap <A-h> <C-\><C-n><C-W><C-H>

" Split resizing
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Switch between different file extensions
map <A-u> :e %:r.ts <CR>
map <A-i> :e %:r.scss <CR>
map <A-o> :e %:r.html <CR>
map <A-d> :e %:r.spec.ts <CR>

" Tab nav
nnoremap <C-j> gT
nnoremap <C-k> gt

" Format file
map <leader>l mzgg=G`zzz

" fzf Fuzzy search mappings
map <silent> <C-P> :Files<CR>
map <silent> <leader>pf :Ag<CR>
map <silent> <leader>pg :GFiles?<CR>
map <silent> <leader>pb :Buffers<CR>
map <silent> <leader>pw :Windows<CR>
map <silent> <leader>ps :Snippets<CR>
map <silent> <leader>pc :Commits<CR>

" NERDTree
map <leader>b :NERDTreeToggle<CR>

]]
