local status, codecompanion = pcall(require, "codecompanion")
if not status then
	return
end

codecompanion.setup({})
-- codecompanion.setup({
--   strategies = {
--     chat = {
--       adapter = "copilot",
--     },
--     inline = {
--       adapter = "copilot",
--     },
--   },
-- })
