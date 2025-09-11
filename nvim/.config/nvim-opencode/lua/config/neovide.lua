if vim.g.neovide then
  vim.o.guifont = "IosevkaTerm Nerd Font Mono:h16"
  vim.g.neovide_normal_opacity = 0.95
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_hide_mouse_when_typing = true

  -- enable clipboard support
  vim.keymap.set(
    { 'n' },
    '<D-c>',
    '"+Y',
    { noremap = true, silent = true })

  vim.keymap.set(
    { 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' },
    '<D-c>',
    '"+y',
    { noremap = true, silent = true })

  vim.keymap.set(
    { 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' },
    '<D-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
  )
end
