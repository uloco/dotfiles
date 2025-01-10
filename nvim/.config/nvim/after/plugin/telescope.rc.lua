local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local fb_actions = require 'telescope'.extensions.file_browser.actions
local action_layout = require 'telescope.actions.layout'

local trouble = require("trouble.sources.telescope")
local path_actions = require('telescope_insert_path')

telescope.setup {
  defaults = {
    path_display = { "filename_first" },
    mappings = {
      n = {
        ['q'] = actions.close,
        ['<A-q>'] = actions.delete_buffer,
        ['<C-a>'] = actions.select_all,
        ["<C-t>"] = trouble.open,
        -- E.g. Type `[i`, `[I`, `[a`, `[A`, `[o`, `[O` to insert relative path and select the path in visual mode.
        -- Other mappings work the same way with a different prefix.
        ["<A-i>"] = path_actions.insert_relpath_i_normal,
        ["<A-l>"] = path_actions.insert_reltobufpath_i_normal,
        ["<A-S-i>"] = path_actions.insert_abspath_i_normal,
        -- If you want to get relative path that is relative to the cwd, use
        -- `relpath` instead of `reltobufpath`
        -- You can skip the location postfix if you specify that in the function name.
        -- ["<C-o>"] = path_actions.insert_relpath_o_visual,
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
      "--follow", -- follow symlinks
      "--hidden"  -- also search .hidden files
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
      -- disables netrw add use telescope-file-broser in its place
      layout_config = {
        height = 30
      },
      hijack_netrw = true,
      initial_mode = "normal",
      hidden = "true",
      grouped = "true",
      mappings = {
        -- your custom insert mode mappings
        ['i'] = {
          ['C-w'] = function() vim.cmd('normal vbd') end,
          ['<M-p>'] = action_layout.toggle_preview,
          ['<esc>'] = function() return vim.cmd('stopinsert') end
        },
        ['n'] = {
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['l'] = actions.select_default,
          ['/'] = function()
            vim.cmd('startinsert')
          end,
          ["<M-p>"] = action_layout.toggle_preview,
          ["H"] = fb_actions.toggle_hidden

        }
      }
    }
  }
}

telescope.load_extension('file_browser')
telescope.load_extension('fzf') -- load telescope-fzf-native

local opts = { noremap = true, silent = true }

-- search files
vim.keymap.set('n', '<leader>ll', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
    follow = true
  })
end, { noremap = true, silent = true, desc = "Find Files" })

-- search ALL files (include ignored files)
vim.keymap.set('n', '<leader>lL', function()
  builtin.find_files({
    no_ignore = true,
    hidden = true,
    follow = true
  })
end, { noremap = true, silent = true, desc = "Find Files" })

-- search old files
vim.keymap.set('n', '<leader><leader>l', function()
  builtin.oldfiles({ no_ignore = true, only_cwd = true })
end, opts)

-- search text
vim.keymap.set('n', '<leader>lf', function()
    builtin.live_grep()
  end,
  { noremap = true, silent = true, desc = "Search in files" })

-- search text fuzzy
vim.keymap.set('n', '<leader>ls', function()
  builtin.grep_string({
    shorten_path = true, word_match = "-w", only_sort_text = true, search = '',
  })
end)

-- search ALL text (including ignored files)
vim.keymap.set('n', '<leader>lF',
  function()
    builtin.live_grep { vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--follow", -- follow symlinks
      "--hidden", -- also search .hidden files
      "-u"
    } }
  end,
  { noremap = true, silent = true, desc = "Search in files" })

-- search open buffers
vim.keymap.set('n', '<leader>lb', function()
  builtin.buffers()
end, opts)

-- search help pages
vim.keymap.set('n', '<leader>lh', function() builtin.help_tags() end, opts)

-- search highlight groups
vim.keymap.set('n', '<leader>lH', function() builtin.highlights() end, opts)

-- resume last search
vim.keymap.set('n', '<leader>lR', function() builtin.resume() end, opts)

-- search errors / warnings / info
vim.keymap.set('n', '<leader>le', function() builtin.diagnostics() end, opts)

-- open file explorer
vim.keymap.set('n', '<leader>fb',
  function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      file_ignore_patterns = {},
      respect_gitignore = false,
      select_buffer = true,
      hidden = true
    })
  end,
  opts)

vim.keymap.set('n', '<leader>lg', function() builtin.git_status() end, opts)

vim.keymap.set('n', '<leader>ld', function() builtin.lsp_definitions() end, opts)
vim.keymap.set('n', '<leader>lt', function() builtin.lsp_type_definitions() end, opts)
vim.keymap.set('n', '<leader>lr', function() builtin.lsp_references() end, opts)
vim.keymap.set('n', '<leader>li', function() builtin.lsp_implementations() end, opts)
vim.keymap.set('n', '<leader>lo', function() builtin.lsp_document_symbols() end, opts)
vim.keymap.set('n', '<leader>lO', function() builtin.lsp_dynamic_workspace_symbols() end, opts)
