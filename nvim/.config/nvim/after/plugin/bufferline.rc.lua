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


local function status_line()
  local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  local file_name = "%t"
  local buf_nr = "[%n]"
  -- local modified = " %#Method# %-m"
  local modified = ""
  local file_type = " %y"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"
  local pct_thru_file = "%5p%%"

  local diagnostics = vim.diagnostics.get
  if "%-m" then
    modified  = "%#Type# •%#Normal#"
  end

  return file_name .. modified
  -- return string.format(
  --   "%s %s",
  --   file_name,
  --   modified,
  -- )
end

-- vim.opt.winbar = status_line()
