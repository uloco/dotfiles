local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    indicator = {
      style = 'underline',
    },
    mode = 'buffers',
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    diagnostics = 'nvim_lsp',
  },
}

local opt = { noremap = true, silent = true }

vim.keymap.set('n', '<A-i>', ':BufferLineCycleNext<CR>', opt)
vim.keymap.set('n', '<A-u>', ':BufferLineCyclePrev<CR>', opt)
vim.keymap.set('n', '<A-S-i>', ':BufferLineMoveNext<CR>', opt)
vim.keymap.set('n', '<A-S-u>', ':BufferLineMovePrev<CR>', opt)

vim.keymap.set('n', '<Leader>gt', ':BufferLinePick<CR>', opt)
