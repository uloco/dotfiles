local status, bufdel = pcall(require, 'bufdel')
if (not status) then return end

bufdel.setup {
  next = 'cycle', -- or 'alternate'
  quit = false,
}

local opt = { noremap = true, silent = true }

local function close()
  local buffers = require("bufferline.utils").get_valid_buffers()
  local buf_count = require("bufferline.utils").get_buf_count()
  local buf_current = vim.fn.bufnr('#')

  local buf_last = buffers[buf_count - 1]

  -- fix last buffer close goes to first
  if (buf_current == buf_last) then
    bufdel.delete_buffer()
    vim.cmd('bprevious')
  else
    bufdel.delete_buffer()
  end
end

vim.keymap.set('n', '<A-q>', function() close() end, opt)
vim.keymap.set('n', '<leader>q', function() close() end, opt)


-- close all buffers
local function close_all()
  local buffers = require("bufferline.utils").get_valid_buffers()
  for a, bufnr in pairs(buffers) do
    pcall(vim.cmd, string.format("BufDel %d", bufnr))
  end
end

vim.keymap.set('n', '<A-S-q>', function() close_all() end, opt)

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

vim.keymap.set('n', '<A-S-t>', function() close_all_but_current() end, opt)
