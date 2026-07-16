-- Mutually-exclusive floating overlays.
-- Ensures that opening lazygit / sidekick / the floating toggleterm hides the
-- others, so only one floating overlay is visible at a time.
-- Split toggleterm terminals are intentionally ignored.

local M = {}

--- Is a window a floating window?
---@param win integer
---@return boolean
local function is_floating_win(win)
	local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
	return ok and cfg.relative ~= nil and cfg.relative ~= ""
end

--- Hide lazygit (floating snacks terminal), unless it is the one being kept.
---@param keep? string
local function hide_lazygit(keep)
	if keep == "lazygit" then
		return
	end
	if not (Snacks and Snacks.terminal) then
		return
	end
	for _, term in ipairs(Snacks.terminal.list()) do
		if term:win_valid() and is_floating_win(term.win) then
			term:hide()
		end
	end
end

--- Hide the floating toggleterm terminal(s), unless kept.
---@param keep? string
local function hide_toggleterm(keep)
	if keep == "toggleterm" then
		return
	end
	local ok, terminal = pcall(require, "toggleterm.terminal")
	if not ok then
		return
	end
	for _, term in ipairs(terminal.get_all(true)) do
		if term:is_float() and term:is_open() then
			term:close()
		end
	end
end

--- Hide all sidekick CLI terminals, unless kept.
---@param keep? string
local function hide_sidekick(keep)
	if keep == "sidekick" then
		return
	end
	local ok, cli = pcall(require, "sidekick.cli")
	if not ok then
		return
	end
	pcall(cli.hide, { all = true })
end

--- Hide every floating overlay except the given one.
---@param keep? "lazygit"|"sidekick"|"toggleterm"
function M.hide_others(keep)
	hide_lazygit(keep)
	hide_toggleterm(keep)
	hide_sidekick(keep)
end

--- Is the overlay identified by `name` currently visible on screen?
---@param name "lazygit"|"sidekick"|"toggleterm"
---@return boolean
local function is_visible(name)
	if name == "toggleterm" then
		local ok, terminal = pcall(require, "toggleterm.terminal")
		if not ok then
			return false
		end
		for _, term in ipairs(terminal.get_all(true)) do
			if term:is_float() and term:is_open() then
				return true
			end
		end
		return false
	elseif name == "lazygit" then
		if not (Snacks and Snacks.terminal) then
			return false
		end
		for _, term in ipairs(Snacks.terminal.list()) do
			if term:win_valid() and is_floating_win(term.win) then
				return true
			end
		end
		return false
	elseif name == "sidekick" then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.bo[buf].filetype == "sidekick_terminal" then
				return true
			end
		end
		return false
	end
	return false
end

--- Open an overlay via `open_fn`, then hide the other overlays only once the
--- new one is actually on screen. This avoids a flicker where the background
--- is briefly visible between hiding the old overlay and drawing the new one.
--- Overlays open asynchronously (notably sidekick), so we poll for visibility.
---@param keep "lazygit"|"sidekick"|"toggleterm"
---@param open_fn fun()
function M.open(keep, open_fn)
	open_fn()

	local attempts = 0
	local function try_hide()
		attempts = attempts + 1
		if is_visible(keep) then
			M.hide_others(keep)
		elseif attempts < 40 then -- give up after ~800ms
			vim.defer_fn(try_hide, 20)
		end
	end
	try_hide()
end

return M
