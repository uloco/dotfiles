local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local fb_actions = require 'telescope'.extensions.file_browser.actions
local action_layout = require 'telescope.actions.layout'

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ['q'] = actions.close,
        ['<C-d>'] = actions.delete_buffer
      },
      i = {
        -- close in insert mode directly TODO: (find a way to override this for file_browser)
        -- ['<esc>'] = actions.close,
        ['<A-q>'] = actions.delete_buffer,
        ['C-u'] = actions.preview_scrolling_up,
        ['C-d'] = actions.preview_scrolling_down,
      }
    },
    file_ignore_patterns = {
      ".git/",
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
    winblend = 15
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
          -- ['<esc>'] = '<C-\\><C-n>'
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
vim.keymap.set('n', '<leader>po', function()
  builtin.oldfiles({ only_cwd = true })
end, opts)

-- search text
vim.keymap.set('n', '<leader>pf', function() builtin.live_grep() end,
  { noremap = true, silent = true, desc = "Search in files" })

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
