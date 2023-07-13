local status, bufferline = pcall(require, 'bufferline')
if (not status or vim.g.started_by_firenvim == true) then return end

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

-- normal mode
vim.keymap.set('n', '<A-i>', '<cmd>BufferLineCycleNext<cr>', opt)
vim.keymap.set('n', '<A-u>', '<cmd>BufferLineCyclePrev<cr>', opt)
vim.keymap.set('n', '<A-S-i>', '<cmd>BufferLineMoveNext<cr>', opt)
vim.keymap.set('n', '<A-S-u>', '<cmd>BufferLineMovePrev<cr>', opt)

vim.keymap.set('n', '<Leader>gt', ':BufferLinePick<cr>', opt)
