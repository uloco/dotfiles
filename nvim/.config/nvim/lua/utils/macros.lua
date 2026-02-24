local M = {}

local data_dir = vim.fn.stdpath("data")
local macros_file = data_dir .. "/saved_macros.json"

--- Load all macros from disk
---@return table[] list of {name: string, description: string, register: string, keys: string}
function M.load()
	local f = io.open(macros_file, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	if content == "" then
		return {}
	end
	local ok, macros = pcall(vim.json.decode, content)
	if not ok then
		vim.notify("Failed to parse saved macros", vim.log.levels.ERROR)
		return {}
	end
	return macros
end

--- Save all macros to disk
---@param macros table[]
function M.save(macros)
	local f = io.open(macros_file, "w")
	if not f then
		vim.notify("Failed to write macros file", vim.log.levels.ERROR)
		return
	end
	f:write(vim.json.encode(macros))
	f:close()
end

--- Save a macro from a register with a description prompt
---@param register? string single character register (defaults to prompting)
function M.save_macro(register)
	local function do_save(reg)
		local keys = vim.fn.getreg(reg)
		if keys == "" then
			vim.notify("Register @" .. reg .. " is empty", vim.log.levels.WARN)
			return
		end

		Snacks.input({ prompt = "Macro name:" }, function(name)
			if not name or name == "" then
				return
			end
			Snacks.input({ prompt = "Description (optional):" }, function(desc)
				local macros = M.load()
				table.insert(macros, 1, {
					name = name,
					description = desc or "",
					register = reg,
					keys = keys,
				})
				M.save(macros)
				vim.notify("Saved macro '" .. name .. "' from @" .. reg, vim.log.levels.INFO)
			end)
		end)
	end

	if register then
		do_save(register)
	else
		Snacks.input({ prompt = "Register to save (a-z):" }, function(reg)
			if not reg or reg == "" then
				return
			end
			reg = reg:sub(1, 1) -- take first character only
			do_save(reg)
		end)
	end
end

--- Delete a macro by index
---@param idx number
function M.delete(idx)
	local macros = M.load()
	if idx < 1 or idx > #macros then
		return
	end
	local removed = table.remove(macros, idx)
	M.save(macros)
	vim.notify("Deleted macro '" .. removed.name .. "'", vim.log.levels.INFO)
end

--- Execute a macro's keys in the current buffer
---@param keys string
function M.execute(keys)
	vim.fn.setreg("m", keys)
	vim.cmd("normal @m")
end

--- Load a macro into a register
---@param keys string
---@param register? string defaults to "q"
function M.load_to_register(keys, register)
	register = register or "q"
	vim.fn.setreg(register, keys)
	vim.notify("Loaded macro into @" .. register, vim.log.levels.INFO)
end

--- Format raw macro keystrokes for display
---@param keys string
---@return string
function M.format_keys(keys)
	return vim.fn.keytrans(keys)
end

--- Execute a macro in a scratch buffer and return the resulting lines
---@param original_lines string[] lines of the original buffer
---@param keys string raw macro keystrokes
---@param cursor_pos integer[] {row, col} (1-indexed row, 0-indexed col)
---@param buf_opts? table buffer options to copy (expandtab, shiftwidth, etc.)
---@return string[]|nil new_lines resulting lines after macro execution
---@return string|nil error error message if macro failed
function M.compute_diff(original_lines, keys, cursor_pos, buf_opts)
	local scratch = vim.api.nvim_create_buf(false, true)

	-- Copy lines into scratch buffer
	vim.api.nvim_buf_set_lines(scratch, 0, -1, false, original_lines)

	-- Apply buffer options if provided
	if buf_opts then
		for k, v in pairs(buf_opts) do
			pcall(vim.api.nvim_set_option_value, k, v, { buf = scratch })
		end
	end

	-- Save and restore register m
	local saved_reg = vim.fn.getreg("m")
	local saved_regtype = vim.fn.getregtype("m")
	vim.fn.setreg("m", keys)

	local ok, err = pcall(vim.api.nvim_buf_call, scratch, function()
		vim.api.nvim_win_set_cursor(0, cursor_pos)
		vim.cmd("noautocmd normal! @m")
	end)

	-- Restore register m
	vim.fn.setreg("m", saved_reg, saved_regtype)

	if not ok then
		pcall(vim.api.nvim_buf_delete, scratch, { force = true })
		return nil, tostring(err)
	end

	local new_lines = vim.api.nvim_buf_get_lines(scratch, 0, -1, false)
	vim.api.nvim_buf_delete(scratch, { force = true })

	return new_lines, nil
end

--- Compute line-level diff hunks between old and new lines
---@param old_lines string[]
---@param new_lines string[]
---@return table[] hunks list of {start_a, count_a, start_b, count_b}
function M.line_diff(old_lines, new_lines)
	local old_text = table.concat(old_lines, "\n") .. "\n"
	local new_text = table.concat(new_lines, "\n") .. "\n"

	-- Handle edge case: both empty
	if #old_lines == 0 and #new_lines == 0 then
		return {}
	end
	-- Handle edge case: one side is empty single line
	if #old_lines == 1 and old_lines[1] == "" and #new_lines == 1 and new_lines[1] == "" then
		return {}
	end

	local hunks = vim.diff(old_text, new_text, { result_type = "indices" })
	return hunks or {}
end

--- Compute character-level diff segments for a pair of changed lines
--- Uses the technique of splicing each character onto its own line
---@param old_line string
---@param new_line string
---@return table[] segments list of {col_start, col_end, kind} where kind is "delete"|"add"|"equal"
function M.char_diff(old_line, new_line)
	-- Splice each byte onto its own line for vim.diff
	local function splice(s)
		if s == "" then
			return "\n"
		end
		local parts = {}
		for i = 1, #s do
			parts[#parts + 1] = s:sub(i, i)
		end
		return table.concat(parts, "\n") .. "\n"
	end

	local spliced_old = splice(old_line)
	local spliced_new = splice(new_line)

	local hunks = vim.diff(spliced_old, spliced_new, { result_type = "indices" }) or {}

	-- Build segments for the merged (display) line
	-- We'll walk both old and new simultaneously, producing segments
	local segments = {}
	local old_pos = 1 -- current byte position in old_line
	local new_pos = 1 -- current byte position in new_line

	for _, hunk in ipairs(hunks) do
		local start_a, count_a, start_b, count_b = hunk[1], hunk[2], hunk[3], hunk[4]

		-- Equal portion before this hunk (from new_line perspective, but old matches)
		local equal_count = start_a - old_pos
		if equal_count > 0 then
			segments[#segments + 1] = {
				text = new_line:sub(new_pos, new_pos + equal_count - 1),
				kind = "equal",
			}
			old_pos = old_pos + equal_count
			new_pos = new_pos + equal_count
		end

		-- Deleted characters (from old)
		if count_a > 0 then
			segments[#segments + 1] = {
				text = old_line:sub(old_pos, old_pos + count_a - 1),
				kind = "delete",
			}
			old_pos = old_pos + count_a
		end

		-- Added characters (from new)
		if count_b > 0 then
			segments[#segments + 1] = {
				text = new_line:sub(new_pos, new_pos + count_b - 1),
				kind = "add",
			}
			new_pos = new_pos + count_b
		end
	end

	-- Trailing equal portion
	if new_pos <= #new_line then
		segments[#segments + 1] = {
			text = new_line:sub(new_pos),
			kind = "equal",
		}
	end

	return segments
end

--- Build a merged preview with inline diff annotations
--- Re-inserts deleted lines/chars and annotates everything with highlight info
---@param old_lines string[]
---@param new_lines string[]
---@return table {lines: string[], highlights: table[], has_changes: boolean}
function M.build_preview(old_lines, new_lines)
	local hunks = M.line_diff(old_lines, new_lines)

	if #hunks == 0 then
		return { lines = new_lines, highlights = {}, has_changes = false }
	end

	local merged_lines = {}
	local highlights = {}
	local old_idx = 1 -- 1-indexed position in old_lines
	local new_idx = 1 -- 1-indexed position in new_lines

	for _, hunk in ipairs(hunks) do
		local start_a, count_a, start_b, count_b = hunk[1], hunk[2], hunk[3], hunk[4]

		-- Copy unchanged lines before this hunk (from new_lines, they're identical)
		while new_idx < start_b and old_idx < start_a do
			merged_lines[#merged_lines + 1] = new_lines[new_idx]
			new_idx = new_idx + 1
			old_idx = old_idx + 1
		end

		if count_a > 0 and count_b > 0 then
			-- Changed lines: do character-level diff for each pair
			local pairs_count = math.min(count_a, count_b)

			for i = 0, pairs_count - 1 do
				local old_line = old_lines[start_a + i]
				local new_line = new_lines[start_b + i]
				local segments = M.char_diff(old_line, new_line)

				-- Build the merged display line from segments
				local display_parts = {}
				local line_highlights = {}
				local col = 0

				for _, seg in ipairs(segments) do
					display_parts[#display_parts + 1] = seg.text
					local seg_len = #seg.text
					if seg.kind == "delete" then
						line_highlights[#line_highlights + 1] = {
							col_start = col,
							col_end = col + seg_len,
							hl_group = "DiffDelete",
						}
					elseif seg.kind == "add" then
						line_highlights[#line_highlights + 1] = {
							col_start = col,
							col_end = col + seg_len,
							hl_group = "DiffAdd",
						}
					end
					col = col + seg_len
				end

				local display_line = table.concat(display_parts)
				local line_nr = #merged_lines -- 0-indexed for extmarks
				merged_lines[#merged_lines + 1] = display_line

				for _, hl in ipairs(line_highlights) do
					highlights[#highlights + 1] = {
						line = line_nr,
						col_start = hl.col_start,
						col_end = hl.col_end,
						hl_group = hl.hl_group,
					}
				end
			end

			-- Extra deleted lines (count_a > count_b)
			for i = pairs_count, count_a - 1 do
				local line_nr = #merged_lines
				merged_lines[#merged_lines + 1] = old_lines[start_a + i]
				highlights[#highlights + 1] = {
					line = line_nr,
					col_start = 0,
					col_end = #old_lines[start_a + i],
					hl_group = "DiffDelete",
				}
			end

			-- Extra added lines (count_b > count_a)
			for i = pairs_count, count_b - 1 do
				local line_nr = #merged_lines
				merged_lines[#merged_lines + 1] = new_lines[start_b + i]
				highlights[#highlights + 1] = {
					line = line_nr,
					col_start = 0,
					col_end = #new_lines[start_b + i],
					hl_group = "DiffAdd",
				}
			end

			old_idx = start_a + count_a
			new_idx = start_b + count_b

		elseif count_a > 0 and count_b == 0 then
			-- Pure deletion: re-insert deleted lines highlighted red
			for i = 0, count_a - 1 do
				local line_nr = #merged_lines
				merged_lines[#merged_lines + 1] = old_lines[start_a + i]
				highlights[#highlights + 1] = {
					line = line_nr,
					col_start = 0,
					col_end = #old_lines[start_a + i],
					hl_group = "DiffDelete",
				}
			end
			old_idx = start_a + count_a

		elseif count_a == 0 and count_b > 0 then
			-- Pure insertion: added lines highlighted green
			for i = 0, count_b - 1 do
				local line_nr = #merged_lines
				merged_lines[#merged_lines + 1] = new_lines[start_b + i]
				highlights[#highlights + 1] = {
					line = line_nr,
					col_start = 0,
					col_end = #new_lines[start_b + i],
					hl_group = "DiffAdd",
				}
			end
			new_idx = start_b + count_b
		end
	end

	-- Copy remaining unchanged lines
	while new_idx <= #new_lines do
		merged_lines[#merged_lines + 1] = new_lines[new_idx]
		new_idx = new_idx + 1
	end

	return { lines = merged_lines, highlights = highlights, has_changes = true }
end

--- Compute fold ranges for large buffers (>= 1000 lines).
--- For smaller buffers, returns no fold ranges.
--- For large buffers, returns ranges of unchanged lines to fold,
--- keeping 10 lines of context around each change visible.
---
---@param diff_result table from build_preview()
---@return table[] fold_ranges list of {start_line, end_line} (1-indexed, inclusive) to fold
function M.compute_folds(diff_result)
	local CONTEXT = 10
	local LARGE_THRESHOLD = 1000

	local total_lines = #diff_result.lines

	-- Small buffer or no changes: no folds needed
	if total_lines < LARGE_THRESHOLD or #diff_result.highlights == 0 then
		return {}
	end

	-- Collect unique changed line numbers (0-indexed from highlights)
	local changed_set = {}
	for _, hl in ipairs(diff_result.highlights) do
		changed_set[hl.line] = true
	end

	-- Build visible ranges: each changed line expanded by ±CONTEXT (0-indexed)
	local ranges = {}
	for line_nr in pairs(changed_set) do
		ranges[#ranges + 1] = {
			math.max(0, line_nr - CONTEXT),
			math.min(total_lines - 1, line_nr + CONTEXT),
		}
	end

	table.sort(ranges, function(a, b)
		return a[1] < b[1]
	end)

	-- Merge overlapping/adjacent ranges
	local merged = { ranges[1] }
	for i = 2, #ranges do
		local prev = merged[#merged]
		local cur = ranges[i]
		if cur[1] <= prev[2] + 1 then
			prev[2] = math.max(prev[2], cur[2])
		else
			merged[#merged + 1] = cur
		end
	end

	-- Invert visible ranges to get fold ranges (gaps between visible regions)
	local folds = {}

	-- Gap before first visible range
	if merged[1][1] > 0 then
		folds[#folds + 1] = { 1, merged[1][1] } -- 1-indexed inclusive
	end

	-- Gaps between visible ranges
	for i = 2, #merged do
		local prev_end = merged[i - 1][2]
		local cur_start = merged[i][1]
		if cur_start > prev_end + 1 then
			folds[#folds + 1] = { prev_end + 2, cur_start } -- 1-indexed inclusive
		end
	end

	-- Gap after last visible range
	local last_end = merged[#merged][2]
	if last_end < total_lines - 1 then
		folds[#folds + 1] = { last_end + 2, total_lines } -- 1-indexed inclusive
	end

	return folds
end

return M
