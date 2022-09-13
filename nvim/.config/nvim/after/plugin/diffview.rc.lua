local actions = require("diffview.actions")

require("diffview").setup({
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  file_panel = {
    listing_style = "list", -- One of 'list' or 'tree'
  },
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      ["gf"]         = actions.goto_file, -- Open the file in a new split in the previous tabpage
      ["<leader>e"]  = actions.focus_files, -- Bring focus to the file panel
      ["<leader>b"]  = actions.toggle_files, -- Toggle the file panel.
      -- ["<leader>l"]  = actions.cycle_layout, -- Cycle through available layouts.
      ["<leader>kc"] = actions.prev_conflict, -- In the merge_tool: jump to the previous conflict
      ["<leader>jc"] = actions.next_conflict, -- In the merge_tool: jump to the next conflict
      ["<leader>co"] = actions.conflict_choose("ours"), -- Choose the OURS version of a conflict
      ["<leader>ct"] = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
      ["<leader>cb"] = actions.conflict_choose("base"), -- Choose the BASE version of a conflict
      ["<leader>ca"] = actions.conflict_choose("all"), -- Choose all the versions of a conflict
      ["<leader>cx"] = actions.conflict_choose("none"), -- Delete the conflict region
    },
    diff1 = { --[[ Mappings in single window diff layouts ]] },
    diff2 = { --[[ Mappings in 2-way diff layouts ]] },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do", actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
      { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    file_panel = {
      ["-"]          = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
      ["S"]          = actions.stage_all, -- Stage all entries.
      ["U"]          = actions.unstage_all, -- Unstage all entries.
      ["X"]          = actions.restore_entry, -- Restore entry to the state on the left side.
      ["R"]          = actions.refresh_files, -- Update stats and entries in the file list.
      ["L"]          = actions.open_commit_log, -- Open the commit log panel.
      ["<c-u>"]      = actions.scroll_view(-0.25), -- Scroll the view up
      ["<c-d>"]      = actions.scroll_view(0.25), -- Scroll the view down
      ["gf"]         = actions.goto_file,
      ["i"]          = actions.listing_style, -- Toggle between 'list' and 'tree' views
      ["f"]          = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]  = actions.focus_files,
      ["<leader>b"]  = actions.toggle_files,
      -- ["<leader>f"]  = actions.cycle_layout,
      ["<leader>kc"] = actions.prev_conflict,
      ["<leader>jc"] = actions.next_conflict,
    },
    file_history_panel = {
      ["g?"]        = actions.options, -- Open the option panel
      ["<C-A-d>"]   = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
      ["y"]         = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
      ["L"]         = actions.open_commit_log,
      ["zR"]        = actions.open_all_folds,
      ["zM"]        = actions.close_all_folds,
      ["<c-u>"]     = actions.scroll_view(-0.25),
      ["<c-d>"]     = actions.scroll_view(0.25),
      ["gf"]        = actions.goto_file,
      ["<leader>e"] = actions.focus_files,
      ["<leader>b"] = actions.toggle_files,
      -- ["<leader>l"] = actions.cycle_layout,
    },
    option_panel = {
      ["<tab>"] = actions.select_entry,
      ["q"]     = actions.close,
    },
  },
})


function DiffviewToggle()
  local lib = require 'diffview.lib'
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd(":DiffviewClose")
  else
    -- No open Diffview exists: open a new one
    vim.cmd(":DiffviewOpen")
  end
end

function DiffviewHistoryToggle()
  local lib = require 'diffview.lib'
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd(":DiffviewClose")
  else
    -- No open Diffview exists: open a new one
    vim.cmd(":DiffviewFileHistory")
  end
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>df', function() DiffviewToggle() end, opts)
vim.keymap.set('n', '<leader>dh', function() DiffviewHistoryToggle() end, opts)
