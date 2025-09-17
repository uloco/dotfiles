local status, scope = pcall(require, "scope")
if not status then
	return
end

scope.setup({})
