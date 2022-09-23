local status, auto_session = pcall(require, 'auto-session')
if (not status) then return end


function _G.close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

auto_session.setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Source", "~/Downloads", "/" },
  pre_save_cmds = { _G.close_all_floating_wins },
}
