local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end

toggleterm.setup({
  hide_numbers = false,
  open_mapping = '<F60>',
  insert_mappings = true,
  terminal_mappings = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 10,
  },
  persist_size = false,
  winbar = {
    enable = true
  }
})
