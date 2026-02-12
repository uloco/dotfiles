-- nvim-recorder: Actively maintained alternative to NeoComposer.nvim
-- Enhances macro management with visual feedback, multiple slots, and easy editing
-- GitHub: https://github.com/chrisgrieser/nvim-recorder

return {
	"chrisgrieser/nvim-recorder",
	dependencies = "rcarriga/nvim-notify", -- optional: for notifications
	keys = {
		-- Start/stop recording to current slot
		{ "q", desc = "Start/Stop Recording Macro" },
		-- Play macro from current slot
		{ "Q", desc = "Play Macro" },
		-- Switch macro slot (cycle through available slots)
		{ "<C-q>", desc = "Switch Macro Slot" },
		-- Edit current macro
		{ "cq", desc = "Edit Macro" },
		-- Delete all macros
		{ "dq", desc = "Delete All Macros" },
		-- Yank (copy) current macro
		{ "yq", desc = "Yank Macro" },
	},
	config = function()
		require("recorder").setup({
			-- Slots to use for macros (single lowercase letters)
			-- Uses registers a-z for storing macros
			slots = { "a", "b", "c" },

			-- Slot management: "static" keeps same slot, "rotate" cycles through slots
			dynamicSlots = "static",

			-- Clear all macros on startup
			clear = false,

			-- Notification log level
			logLevel = vim.log.levels.INFO, -- :h vim.log.levels

			-- Key mappings (can be customized)
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = "<C-q>",
				editMacro = "cq",
				deleteAllMacros = "dq",
				yankMacro = "yq",
				-- Macro breakpoints - pause macro execution at ##
				addBreakPoint = "##",
			},

			-- Performance mode for large macros (with many incremental changes)
			-- Disables highlighting during macro execution
			performanceOpts = {
				countThreshold = 100, -- Threshold to trigger performance mode
				lazyredraw = true, -- Set lazyredraw during execution
				intervalNotification = 150, -- Notify every X times
			},
		})
	end,
}
