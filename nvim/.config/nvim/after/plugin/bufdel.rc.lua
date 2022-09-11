local status, bufdel = pcall(require, 'bufdel')
if (not status) then return end

bufdel.setup {
  next = 'cycle', -- or 'alternate'
  quit = false,
}

local opt = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>q', ':BufDel<CR>:BufferLineCyclePrev<CR>', opt)
vim.keymap.set('n', '<Leader><Leader>q', ':BufDel!<CR>:BufferLineCyclePrev<CR>', opt)
