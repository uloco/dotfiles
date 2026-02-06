--- Returns a meaningful label for a tab:
--- 1. Manual name (set via :TabRename)
--- 2. tcd directory name (if :tcd was used)
--- 3. Active buffer filename (fallback)
local function tab_label(tabpage)
	-- Check for manual name
	local ok, name = pcall(vim.api.nvim_tabpage_get_var, tabpage, "tab_name")
	if ok and name and name ~= "" then
		return name
	end

	-- Check for tab-local cwd (set via :tcd)
	local tab_cwd = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
	local global_cwd = vim.fn.getcwd(-1, 0)
	if tab_cwd ~= global_cwd then
		return vim.fn.fnamemodify(tab_cwd, ":t")
	end

	-- Fallback: active buffer filename
	local win = vim.api.nvim_tabpage_get_win(tabpage)
	local buf = vim.api.nvim_win_get_buf(win)
	local bufname = vim.api.nvim_buf_get_name(buf)
	if bufname == "" then
		return "[No Name]"
	end
	return vim.fn.fnamemodify(bufname, ":t")
end

--- Winbar filename: "name ●" or " Terminal N  process" for terminals
local function winbar_filename()
	if vim.bo.buftype == "terminal" then
		local buf = vim.api.nvim_get_current_buf()
		local ok, snacks = pcall(vim.api.nvim_buf_get_var, buf, "snacks_terminal")
		local label = " Terminal"
		if ok and snacks then
			label = label .. " " .. snacks.count
		end
		local title = vim.b.term_title
		if title and title ~= "" then
			label = label .. "  " .. title
		end
		return label
	end

	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return "[No Name]"
	end
	local name = vim.fn.fnamemodify(bufname, ":t")
	if vim.bo.modified then
		name = name .. " ●"
	end
	if vim.bo.readonly then
		name = name .. " "
	end
	return name
end

--- Winbar path: short relative parent directory, or terminal cwd
local function winbar_path()
	if vim.bo.buftype == "terminal" then
		local bufname = vim.api.nvim_buf_get_name(0)
		local cwd = bufname:match("^term://(.-)//")
		if cwd then
			return vim.fn.fnamemodify(cwd, ":~")
		end
		return ""
	end
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return ""
	end
	local dir = vim.fn.fnamemodify(bufname, ":~:.:h")
	if dir == "." then
		return ""
	end
	return dir
end

--- Count of unsaved buffers (excluding current)
local function unsaved_buffers()
	local count = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and vim.bo[buf].buflisted then
			count = count + 1
		end
	end
	if count == 0 then
		return ""
	end
	return "● " .. count
end

-- :TabRename command to manually name tabs
vim.api.nvim_create_user_command("TabRename", function(args)
	vim.api.nvim_tabpage_set_var(0, "tab_name", args.args)
end, { nargs = "?", desc = "Rename current tab (empty to clear)" })

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"will-lynas/grapple-line.nvim",
	},
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					winbar = { "NvimTree", "Lazy", "mason", "qf", "help", "grapple" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 0,
					},
				},
				lualine_x = {
					{
						unsaved_buffers,
						color = "Cursor",
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {
					require("grapple-line").lualine,
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"tabs",
						mode = 2, -- show tab number + label
						fmt = function(_, context)
							return tab_label(context.tabnr)
						end,
					},
				},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ winbar_filename },
					{ winbar_path, color = "Comment" },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ winbar_filename },
					{ winbar_path, color = "Comment" },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "nvim-tree", "lazy", "mason", "quickfix" },
		})
	end,
}
