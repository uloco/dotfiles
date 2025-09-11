return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
  local lualine = require("lualine")
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
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
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
        section_separators = { left = '\ue0b0', right = '\ue0b2' },
        component_separators = { left = '\ue0b1', right = '\ue0b3' },
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
          'filename',
          file_status = true,
          path = 0
        } },
        lualine_x = {
          {
            'diagnostics',
            sources = { "nvim_diagnostic" },
            symbols = {
              error = '\uf188 ',
              warn = '\uf071 ',
              info = '\uf449 ',
              hint = '\uf0eb '
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
          file_status = true,
          path = 1
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { 'fugitive' }
    }
  end
end,
}
