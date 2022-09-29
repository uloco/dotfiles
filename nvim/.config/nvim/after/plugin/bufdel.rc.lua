local status, bufdel = pcall(require, 'bufdel')
if (not status) then return end

bufdel.setup {
  next = 'tabs',
  quit = false,
}

local opt = { noremap = true, silent = true }

vim.keymap.set({'n', 'i', 'v', 't'}, '<A-q>', bufdel.delete_buffer, opt)
vim.keymap.set({'n', 'v'}, '<leader>q', bufdel.delete_buffer, opt)


-- close all buffers
local function close_all()
  local buffers = require("bufferline.utils").get_valid_buffers()
  for _, bufnr in pairs(buffers) do
    pcall(vim.cmd, string.format("BufDel %d", bufnr))
  end
end

vim.keymap.set({'n', 'i', 'v', 't'}, '<A-S-q>', function() close_all() end, opt)

-- close all but current
local function close_all_but_current()
  local current = vim.api.nvim_get_current_buf()
  local buffers = require("bufferline.utils").get_valid_buffers()
  for _, bufnr in pairs(buffers) do
    if bufnr ~= current then
      pcall(vim.cmd, string.format("BufDel %d", bufnr))
    end
  end
end

vim.keymap.set({'n', 'i', 'v', 't'}, '<A-S-t>', function() close_all_but_current() end, opt)

