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

return M
