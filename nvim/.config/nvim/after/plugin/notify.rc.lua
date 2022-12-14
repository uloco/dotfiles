local status, notify = pcall(require, 'notify')
if (not status) then return end

notify.setup({
  level = 3
})
-- allow other plugins to use this as default
vim.notify = notify

-- tests
-- notify("error jockl", "error")
-- notify("warning", "warn")
-- notify("info", "info")
-- notify("debug", "debug")
-- notify("trace", "trace")
