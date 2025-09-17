local status, bluloco = pcall(require, "bluloco")
if not status then
	return
end

bluloco.setup({
	style = "auto",
	transparent = true,
	italics = false,
})

vim.cmd("colorscheme bluloco")
