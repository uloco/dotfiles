return {
  "akinsho/git-conflict.nvim",
  event = "BufReadPre",
  version = "*",
  opts = {
    default_mappings = false, -- disable buffer local mapping created by this plugin
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
  },
  keys = {
    { "<leader>co", "<cmd>GitConflictChooseOurs<cr>",   desc = "Choose Ours" },
    { "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
    { "<leader>cb", "<cmd>GitConflictChooseBoth<cr>",   desc = "Choose Both" },
    { "<leader>cn", "<cmd>GitConflictChooseNone<cr>",   desc = "Choose None" },
    { "<leader>jc", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
    { "<leader>kc", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
    { "<leader>cl", "<cmd>GitConflictListQf<cr>",       desc = "List Conflicts in Quickfix" },
  },
}
