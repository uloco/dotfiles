-- Only loaded for its treesitter query definitions (textobjects.scm).
-- All keymaps and textobject selection are handled by mini.ai.
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	lazy = false,
}
