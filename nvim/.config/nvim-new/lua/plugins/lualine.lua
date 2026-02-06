-- Tab label: :TabRename override > :tcd dirname > active filename
local function tab_label(tabpage)
	local ok, name = pcall(vim.api.nvim_tabpage_get_var, tabpage, "tab_name")
	if ok and name and name ~= "" then
		return name
	end

	local tab_cwd = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
	local global_cwd = vim.fn.getcwd(-1, 0)
	if tab_cwd ~= global_cwd then
		return vim.fn.fnamemodify(tab_cwd, ":t")
	end

	local win = vim.api.nvim_tabpage_get_win(tabpage)
	local buf = vim.api.nvim_win_get_buf(win)
	local bufname = vim.api.nvim_buf_get_name(buf)
	if bufname == "" then
		return "[No Name]"
	end
	return vim.fn.fnamemodify(bufname, ":t")
end

local function winbar_filename()
	if vim.bo.buftype == "terminal" then
		-- snacks_terminal buf var holds { count = N } for numbered terminals
		local ok, snacks = pcall(vim.api.nvim_buf_get_var, 0, "snacks_terminal")
		local label = "T"
		if ok and type(snacks) == "table" and snacks.count then
			label = label .. snacks.count
		end
		label = label .. "/"
		local title = vim.b.term_title
		if title and title ~= "" then
			label = label .. " " .. title
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

local function winbar_path()
	if vim.bo.buftype == "terminal" then
		-- parse cwd from term://path//pid:cmd buffer name
		local cwd = vim.api.nvim_buf_get_name(0):match("^term://(.-)//")
		return cwd and vim.fn.fnamemodify(cwd, ":~") or ""
	end
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return ""
	end
	local dir = vim.fn.fnamemodify(bufname, ":~:.:h")
	return dir ~= "." and dir or ""
end

local function unsaved_buffers()
	local count = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and vim.bo[buf].buflisted then
			count = count + 1
		end
	end
	return count > 0 and "● " .. count or ""
end

vim.api.nvim_create_user_command("TabRename", function(args)
	vim.api.nvim_tabpage_set_var(0, "tab_name", args.args)
end, { nargs = "?", desc = "Rename current tab (empty to clear)" })

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "will-lynas/grapple-line.nvim" },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					winbar = { "NvimTree", "Lazy", "mason", "qf", "help", "grapple" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "filename" },
				lualine_x = {
					{ unsaved_buffers, color = "Cursor" },
					{
						"diagnostics",
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
			tabline = {
				lualine_a = { require("grapple-line").lualine },
				lualine_z = {
					{
						"tabs",
						mode = 2,
						fmt = function(_, context)
							return tab_label(context.tabnr)
						end,
					},
				},
			},
			winbar = {
				lualine_c = {
					{ winbar_filename },
					{ winbar_path, color = "Comment" },
				},
			},
			inactive_winbar = {
				lualine_c = {
					{ winbar_filename },
					{ winbar_path, color = "Comment" },
				},
			},
			extensions = { "nvim-tree", "lazy", "mason", "quickfix" },
		})
	end,
}
