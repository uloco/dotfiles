local status, bufdel = pcall(require, 'bufdel')
if (not status) then return end

bufdel.setup {
  next = 'tabs',
  quit = false,
}

local opt = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i', 'v', 't' }, '<A-q>', '<cmd>:BufDel<cr>', opt)
vim.keymap.set({ 'n', 'i', 'v', 't' }, '<A-S-q>', '<cmd>BufDelAll<cr>', opt)
vim.keymap.set({ 'n', 'i', 'v', 't' }, '<A-S-t>', '<cmd>BufDelOthers<cr>', opt)
