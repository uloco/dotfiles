-- hover.nvim provider that shows npm registry info for package.json dependencies.

local SECTIONS = {
	dependencies = true,
	devDependencies = true,
	peerDependencies = true,
	optionalDependencies = true,
}

--- @type table<string, Hover.Provider.Result|false>
local cache = {}

--- @param bufnr integer
--- @param pair TSNode
--- @return string
local function key_of(bufnr, pair)
	return vim.treesitter.get_node_text(pair:field("key")[1], bufnr):sub(2, -2)
end

--- Name of the dependency whose key or version is at `pos`, if any.
--- @param bufnr integer
--- @param pos [integer, integer]
--- @return string?
local function package_at(bufnr, pos)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "json")
	if not ok or not parser then
		return nil
	end
	parser:parse()

	local node = vim.treesitter.get_node({ bufnr = bufnr, pos = { pos[1] - 1, pos[2] } })
	while node and node:type() ~= "pair" do
		node = node:parent()
	end

	local section = node and node:parent() and node:parent():parent()
	if section and section:type() == "pair" and SECTIONS[key_of(bufnr, section)] then
		return key_of(bufnr, node)
	end
end

--- @param pkg table
--- @return string[]
local function format(pkg)
	local license = type(pkg.license) == "table" and pkg.license.type or pkg.license
	local repo = type(pkg.repository) == "table" and pkg.repository.url or pkg.repository
	local lines = { ("**%s@%s**"):format(pkg.name, pkg.version), "" }

	local function add(fmt, value)
		if value and value ~= "" then
			lines[#lines + 1] = fmt:format(tostring(value))
		end
	end

	add("%s", pkg.description)
	add("Deprecated: %s", pkg.deprecated)
	lines[#lines + 1] = ""
	add("License: %s", license)
	add("Homepage: %s", pkg.homepage)
	add("Repository: %s", repo and repo:gsub("^git%+", ""):gsub("%.git$", ""))
	return lines
end

--- @type Hover.Provider
return {
	name = "npm",
	enabled = function(bufnr, opts)
		return vim.fs.basename(vim.api.nvim_buf_get_name(bufnr)) == "package.json"
			and vim.fn.executable("npm") == 1
			and package_at(bufnr, opts.pos) ~= nil
	end,
	execute = function(params, done)
		local name = package_at(params.bufnr, params.pos)
		if not name then
			return done(false)
		end
		if cache[name] ~= nil then
			return done(cache[name])
		end

		vim.system({ "npm", "view", name, "--json" }, { text = true }, function(obj)
			local ok, pkg = pcall(vim.json.decode, obj.stdout or "")
			cache[name] = obj.code == 0
					and ok
					and type(pkg) == "table"
					and { lines = format(pkg), filetype = "markdown" }
				or false
			done(cache[name])
		end)
	end,
}
