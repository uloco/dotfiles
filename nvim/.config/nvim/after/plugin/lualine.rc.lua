local status, lualine = pcall(require, "lualine")
if (not status) then return end

if (vim.g.started_by_firenvim == true) then
  lualine.setup {
    options = {
      icons_enabled = false,
      theme = 'auto',
      section_separators = { left = ' ', right = ' ' },
      component_separators = { left = '|', right = '|' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
      },
      lualine_y = {},
      lualine_z = {}
    },
    inactive_sections = {
      lualine_a = { 'mode' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
      },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
  }
else
  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0            -- 0 = just filename, 1 = relative path, 2 = absolute path
      } },
      lualine_x = {
        {
          'diagnostics',
          sources = { "nvim_diagnostic" },
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' '
          }
        },
        'encoding',
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
      } },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    -- winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { 'filename' },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    -- inactive_winbar = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = { 'filename' },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    extensions = { 'fugitive' }
  }
end
