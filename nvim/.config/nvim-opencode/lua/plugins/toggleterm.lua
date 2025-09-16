return {
  "akinsho/toggleterm.nvim",
  tag = "v2.12.0",
  opts = {
    hide_numbers = false,
    open_mapping = '†', -- Alt-Gr + t
    insert_mappings = true,
    terminal_mappings = true,
    direction = 'vertical',
    size = 80,
    autochdir = true,
    float_opts = {
      border = 'curved',
      winblend = 0,
    },
    persist_size = false,
    winbar = {
      enabled = true
    },
    auto_scroll = false,
    close_on_exit = true,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require('toggleterm.terminal').Terminal

    local lazygit  = Terminal:new({
      id = 100,
      cmd = [[
        THEME=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark || echo light)
        XDG_CONFIG_DIR=${HOME}/.config
        CONFIG_BASE=${XDG_CONFIG_DIR}/lazygit/config.yml
        CONFIG_THEME=${XDG_CONFIG_DIR}/lazygit/config-${THEME}.yml
        lazygit --use-config-file=${CONFIG_BASE},${CONFIG_THEME}
      ]],
      hidden = true,
      direction = 'float',
    })

    local floating = Terminal:new({
      id = 101,
      cmd = "zsh",
      hidden = true,
      direction = 'float'
    })

    local opencode = Terminal:new({
      id = 102,
      cmd = 'opencode',
      hidden = true,
      direction = 'float'
    })

    local opts = { noremap = true, silent = true }
    vim.keymap.set({ "n", "t" }, "˝", "<cmd>ToggleTermToggleAll<cr>", opts) -- Alt-Gr + shift + t
    vim.keymap.set({ "n", "t" }, "©", function()
      lazygit:toggle()
      vim.cmd('checktime')
    end, opts)
    vim.keymap.set({ "n", "t" }, "ª", function() floating:toggle() end, opts)
    vim.keymap.set({ "n", "t" }, "å", function() opencode:toggle() end, opts)

    local cmd = vim.api.nvim_create_user_command
    cmd("LazygitOpen", function() lazygit:open() end, {})
    cmd("LazygitToggle", function() lazygit:toggle() end, {})
    cmd("LazygitClose", function() lazygit:close() end, {})

    -- Auto insert mode when entering terminal
    local augroup_term_insert = vim.api.nvim_create_augroup("Term-Insert", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "TermOpen", "TermEnter" }, {
      group = augroup_term_insert,
      pattern = 'term://*',
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local filetype = vim.bo.filetype
        -- Exclude opencode.nvim terminal by buffer name or filetype
        if not (bufname:match(":opencode") or filetype == "opencode") then
          vim.cmd("startinsert")
        end
      end,
    })

    -- Auto insert mode when entering terminal with mouse click
    local augroup_term_insert_mouse = vim.api.nvim_create_augroup("Term-Insert-Mouse", { clear = true })
    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      group = augroup_term_insert_mouse,
      pattern = '*',
      command = 'nnoremap <buffer><LeftRelease> <LeftRelease>i'
    })
  end,
}
