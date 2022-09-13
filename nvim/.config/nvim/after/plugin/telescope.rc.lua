local status, telescope = pcall(require, 'telescope')
if (not status) then return end

function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

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
        ["<C-u>"] = false,
        ['<C-d>'] = actions.delete_buffer,
        ['A-u'] = actions.preview_scrolling_up,
        ['A-d'] = actions.preview_scrolling_down,
      }
    },
    file_ignore_patterns = {
      ".git/",
      "node_modules/",
      "Pods/",
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
    }
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- disables netrw add use telescope-file-broser in its place
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

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>pp',
  '<cmd>lua require("telescope.builtin").find_files({no_ignore = false, hidden = true, follow = true})<cr>',
  opts)
vim.keymap.set('n', '<leader>pf',
  '<cmd>lua require("telescope.builtin").live_grep()<cr>',
  opts)
vim.keymap.set('n', '<leader>pb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
vim.keymap.set('n', '<leader>ph', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
vim.keymap.set('n', '<leader>pr', '<cmd>lua require("telescope.builtin").resume()<cr>', opts)
vim.keymap.set('n', '<leader>pe', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts)
vim.keymap.set('n', 'sf',
  -- '<cmd>lua require("telescope").extensions.file_browser.file_browser({path = "%:p:h", cwd = telescope_buffer_dir(), respect_gitignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal", layout_config = {height = 80} })<cr>'
  '<cmd>lua require("telescope").extensions.file_browser.file_browser({path = "%:p:h", cwd = telescope_buffer_dir(), respect_gitignore = false, })<cr>'
  , opts)

vim.keymap.set('n', '<leader>pg', '<cmd>lua require("telescope.builtin").git_status()<cr>', opts)
