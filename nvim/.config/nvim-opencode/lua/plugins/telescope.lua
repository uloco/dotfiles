return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function(_, opts)
  local telescope = require('telescope')
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local fb_actions = require 'telescope'.extensions.file_browser.actions
  local action_layout = require 'telescope.actions.layout'
  local trouble = require("trouble.sources.telescope")
  local path_actions = require('telescope_insert_path')
  local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
  end
  telescope.setup {
    defaults = {
      path_display = { "filename_first" },
      mappings = {
        n = {
          ['q'] = actions.close,
          ['<A-q>'] = actions.delete_buffer,
          ['<C-a>'] = actions.select_all,
          ["<C-t>"] = trouble.open,
          ["<A-i>"] = path_actions.insert_relpath_i_normal,
          ["<A-l>"] = path_actions.insert_reltobufpath_i_normal,
          ["<A-S-i>"] = path_actions.insert_abspath_i_normal,
        },
        i = {
          ['<esc>'] = actions.close,
          ['<A-q>'] = actions.delete_buffer,
          ['<C-a>'] = actions.select_all,
          ['<A-e>'] = function() vim.cmd('stopinsert') end,
          ['C-u'] = actions.preview_scrolling_up,
          ['C-d'] = actions.preview_scrolling_down,
          ["<C-t>"] = trouble.open,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<A-i>"] = path_actions.insert_relpath_i_normal,
          ["<A-l>"] = path_actions.insert_reltobufpath_i_normal,
          ["<A-S-i>"] = path_actions.insert_abspath_i_normal,
        }
      },
      file_ignore_patterns = {
        "^.git/",
        ".DS_Store",
        ".vimundo",
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--follow",
        "--hidden"
      },
      winblend = 5,
    },
    pickers = {
      live_grep = {
        mappings = {
          i = { ["<c-f>"] = actions.to_fuzzy_refine },
        },
      },
    },
    extensions = {
      file_browser = {
        theme = 'dropdown',
        layout_config = { height = 30 },
        hijack_netrw = true,
        initial_mode = "normal",
        hidden = "true",
        grouped = "true",
        mappings = {
          i = {
            ['C-w'] = function() vim.cmd('normal vbd') end,
            ['<M-p>'] = action_layout.toggle_preview,
            ['<esc>'] = function() return vim.cmd('stopinsert') end
          },
          n = {
            ['N'] = fb_actions.create,
            ['h'] = fb_actions.goto_parent_dir,
            ['l'] = actions.select_default,
            ['/'] = function() vim.cmd('startinsert') end,
            ["<M-p>"] = action_layout.toggle_preview,
            ["H"] = fb_actions.toggle_hidden
          }
        }
      }
    }
  }
  telescope.load_extension('file_browser')
  telescope.load_extension('fzf')
  local opts_map = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>ll', function()
    builtin.find_files({ no_ignore = false, hidden = true, follow = true })
  end, { noremap = true, silent = true, desc = "Find Files" })
  vim.keymap.set('n', '<leader>lL', function()
    builtin.find_files({ no_ignore = true, hidden = true, follow = true })
  end, { noremap = true, silent = true, desc = "Find Files" })
  vim.keymap.set('n', '<leader><leader>l', function()
    builtin.oldfiles({ no_ignore = true, only_cwd = true })
  end, opts_map)
  vim.keymap.set('n', '<leader>lf', function() builtin.live_grep() end, { noremap = true, silent = true, desc = "Search in files" })
  vim.keymap.set('n', '<leader>ls', function()
    builtin.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' })
  end)
  vim.keymap.set('n', '<leader>lF', function()
    builtin.live_grep { vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--follow", "--hidden", "-u"
    } }
  end, { noremap = true, silent = true, desc = "Search in files" })
  vim.keymap.set('n', '<leader>lb', function() builtin.buffers() end, opts_map)
  vim.keymap.set('n', '<leader>lh', function() builtin.help_tags() end, opts_map)
  vim.keymap.set('n', '<leader>lH', function() builtin.highlights() end, opts_map)
  vim.keymap.set('n', '<leader>lR', function() builtin.resume() end, opts_map)
  vim.keymap.set('n', '<leader>le', function() builtin.diagnostics() end, opts_map)
  vim.keymap.set('n', '<leader>fb', function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      file_ignore_patterns = {},
      respect_gitignore = false,
      select_buffer = true,
      hidden = true
    })
  end, opts_map)
  vim.keymap.set('n', '<leader>lg', function() builtin.git_status() end, opts_map)
  vim.keymap.set('n', '<leader>ld', function() builtin.lsp_definitions() end, opts_map)
  vim.keymap.set('n', '<leader>lt', function() builtin.lsp_type_definitions() end, opts_map)
  vim.keymap.set('n', '<leader>lr', function() builtin.lsp_references() end, opts_map)
  vim.keymap.set('n', '<leader>li', function() builtin.lsp_implementations() end, opts_map)
  vim.keymap.set('n', '<leader>lo', function() builtin.lsp_document_symbols() end, opts_map)
  vim.keymap.set('n', '<leader>lO', function() builtin.lsp_dynamic_workspace_symbols() end, opts_map)
end,
}
