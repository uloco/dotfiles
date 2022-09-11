local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    mode = 'buffers',
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    diagnostics = 'nvim_lsp',
  },
}

local opt = { noremap = true, silent = true }
vim.keymap.set('n', 'gt', ':BufferLineCycleNext<CR>', opt)
vim.keymap.set('n', 'gT', ':BufferLineCyclePrev<CR>', opt)

vim.keymap.set('n', '<Leader>gt', ':BufferLinePick<CR>', opt)
