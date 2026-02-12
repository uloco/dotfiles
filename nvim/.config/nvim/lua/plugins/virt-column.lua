return {
	"lukas-reineke/virt-column.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		char = "┊",
		virtcolumn = "80",
		exclude = {
			"help",
			"terminal",
			"sidekick_terminal",
			"lazy",
			"Trouble",
			"TroubleTrouble",
			"alpha",
		},
	},
}
