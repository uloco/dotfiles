local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local fb_actions = require 'telescope'.extensions.file_browser.actions
local action_layout = require 'telescope.actions.layout'

local trouble = require("trouble.providers.telescope")

telescope.setup {
  defaults = {
    -- TODO: path like is kind of nice but broken in file_browser
    -- path_display = function(opts, path)
    --   local name = require("telescope.utils").path_tail(path)
    --   local location = string.sub(path, 0, -string.len(name) - 1)
    --   return string.format("%s          (%s)", name, path)
    -- end,
    mappings = {
      n = {
        ['q'] = actions.close,
        ['<A-d>'] = actions.delete_buffer,
        ["<C-t>"] = trouble.open_with_trouble,
      },
      i = {
        ['<esc>'] = actions.close,
        ['<A-d>'] = actions.delete_buffer,
        ['<A-e>'] = function() vim.cmd('stopinsert') end,
        ['C-u'] = actions.preview_scrolling_up,
        ['C-d'] = actions.preview_scrolling_down,
        ["<C-t>"] = trouble.open_with_trouble,
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
      "--hidden" -- also search .hidden files
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
          ['<esc>'] = function () return vim.cmd('stopinsert') end
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
vim.keymap.set('n', '<leader>pp', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
    follow = true
  })
end, { noremap = true, silent = true, desc = "Find Files" })

-- search text
vim.keymap.set('n', '<leader><leader>p', function()
  builtin.oldfiles({ no_ignore = true, only_cwd = true })
end, opts)

-- search text
vim.keymap.set('n', '<leader>pf', function() builtin.live_grep() end,
  { noremap = true, silent = true, desc = "Search in files" })


vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({
    shorten_path = true, word_match = "-w", only_sort_text = true, search = '',
  })
end)


-- search ALL text (including ignored files)
vim.keymap.set('n', '<leader>pF',
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
vim.keymap.set('n', '<leader>pb', function() builtin.buffers() end, opts)

-- search help pages
vim.keymap.set('n', '<leader>ph', function() builtin.help_tags() end, opts)

-- resume last search
vim.keymap.set('n', '<leader>pR', function() builtin.resume() end, opts)

-- search errors / warnings / info
vim.keymap.set('n', '<leader>pe', function() builtin.diagnostics() end, opts)

-- open file explorer
vim.keymap.set('n', '<leader>fb',
  function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      file_ignore_patterns = {},
      respect_gitignore = false,
    })
  end,
  opts)

vim.keymap.set('n', '<leader>pg', function() builtin.git_status() end, opts)

vim.keymap.set('n', '<leader>pd', function() builtin.lsp_definitions() end, opts)
vim.keymap.set('n', '<leader>pt', function() builtin.lsp_type_definitions() end, opts)
vim.keymap.set('n', '<leader>pr', function() builtin.lsp_references() end, opts)
vim.keymap.set('n', '<leader>pi', function() builtin.lsp_implementations() end, opts)
vim.keymap.set('n', '<leader>po', function() builtin.lsp_document_symbols() end, opts)
vim.keymap.set('n', '<leader>pO', function() builtin.lsp_dynamic_workspace_symbols() end, opts)
