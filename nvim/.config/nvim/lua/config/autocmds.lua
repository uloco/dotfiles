-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- follow help tags with K
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("help_keymaps"),
	pattern = { "help" },
	callback = function(event)
		vim.keymap.set("n", "K", "<C-]>", {
			buffer = event.buf,
			silent = true,
			desc = "Follow help tag",
		})
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Disable auto comments on next line
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("format_options"),
	callback = function()
		vim.opt.formatoptions:remove({ "o" })
	end,
})

-- Restart prettierd on write to any prettier config file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("RestartPrettierd", { clear = true }),
	pattern = "*prettier*",
	callback = function()
		vim.fn.system("prettierd restart")
	end,
})

-- Gray cursor marks normal mode in terminal buffers. 'guicursor' is global, so
-- swap the Cursor highlight instead. Gray derives from the Normal foreground to
-- track the colorscheme's light/dark variant.
local cursor_saved, cursor_grayed

local function cursor_gray()
	if cursor_grayed then
		return
	end
	cursor_saved = cursor_saved or vim.api.nvim_get_hl(0, { name = "Cursor", link = false })
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	vim.api.nvim_set_hl(0, "Cursor", { fg = cursor_saved.fg, bg = normal.fg })
	cursor_grayed = true
end

local function cursor_restore()
	if not cursor_grayed then
		return
	end
	vim.api.nvim_set_hl(0, "Cursor", cursor_saved)
	cursor_grayed = false
end

vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter", "WinEnter" }, {
	group = augroup("term_normal_cursor"),
	callback = function()
		if vim.bo.buftype == "terminal" and vim.fn.mode() ~= "t" then
			cursor_gray()
		else
			cursor_restore()
		end
	end,
})

-- Drop the cached colors so the next swap picks up the new colorscheme.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup("term_normal_cursor_reset"),
	callback = function()
		cursor_saved, cursor_grayed = nil, false
		if vim.bo.buftype == "terminal" and vim.fn.mode() ~= "t" then
			cursor_gray()
		end
	end,
})

-- Notify sidekick CLI processes of theme changes via Mode 2031 (DECRPM).
-- Ghostty sends these natively when macOS appearance changes. Neovim's embedded
-- terminal does not, so opencode/claude never learn about the switch.
-- Only sidekick terminals get it; a shell would render the bytes as prompt junk.
vim.api.nvim_create_autocmd("OptionSet", {
	group = augroup("terminal_theme_notify"),
	pattern = "background",
	callback = function()
		local seq = vim.o.background == "dark" and "\027[?997;1n" or "\027[?997;2n"
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].filetype == "sidekick_terminal" then
				pcall(vim.fn.chansend, vim.bo[buf].channel, seq)
			end
		end
		-- Re-enter terminal mode so the cursor picks up the new highlight.
		-- The delay waits for the colorscheme to rebuild its highlights.
		vim.defer_fn(function()
			if vim.fn.mode() ~= "t" then
				return
			end
			vim.api.nvim_feedkeys(vim.keycode("<C-\\><C-n>i"), "n", false)
		end, 50)
	end,
})
