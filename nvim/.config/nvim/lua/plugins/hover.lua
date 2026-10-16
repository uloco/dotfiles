-- Buffer-local keys that only act while a hover is open. Once the hover is
-- gone the maps remove themselves and pass the key through, so global
-- mappings (sidekick <Tab>, jumplist, macro recording with q) keep working.
local function unmap_hover_keys(bufnr)
	for _, key in ipairs({ "<Tab>", "<S-Tab>", "<Esc>", "q" }) do
		pcall(vim.keymap.del, "n", key, { buffer = bufnr })
	end
end

local function close_hover(bufnr)
	require("hover").close(bufnr)
	unmap_hover_keys(bufnr)
end

local hover_keys = {
	["<Tab>"] = function()
		require("hover").switch("next")
	end,
	["<S-Tab>"] = function()
		require("hover").switch("previous")
	end,
	["<Esc>"] = close_hover,
	["q"] = close_hover,
}

local function map_hover_keys(bufnr)
	for key, action in pairs(hover_keys) do
		vim.keymap.set("n", key, function()
			local hover_win = vim.b[bufnr].hover_preview
			if hover_win and vim.api.nvim_win_is_valid(hover_win) then
				action(bufnr)
				return
			end
			unmap_hover_keys(bufnr)
			-- "i": insert in front of pending typeahead so e.g. `qa` stays in order
			vim.api.nvim_feedkeys(vim.keycode(key), "mi", false)
		end, { buffer = bufnr, desc = "hover.nvim" })
	end
end

return {
	"lewis6991/hover.nvim",
	keys = {
		{
			"gh",
			function()
				if vim.w.hover_preview then
					-- inside the hover window: go back to the source window
					vim.cmd.wincmd("p")
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local hover_win = vim.b[bufnr].hover_preview
				if hover_win and vim.api.nvim_win_is_valid(hover_win) then
					require("hover").enter()
					vim.keymap.set("n", "<Esc>", "<cmd>bdelete<cr>", {
						buffer = vim.api.nvim_win_get_buf(hover_win),
						nowait = true,
						desc = "hover.nvim (close)",
					})
				else
					map_hover_keys(bufnr)
					require("hover").open()
				end
			end,
			desc = "hover.nvim",
		},
	},
	config = function()
		require("hover").config({
			-- Higher priority comes first in the hover tabs.
			providers = {
				{ module = "utils.hover_npm", priority = 1100 },
				{ module = "hover.providers.diagnostic", priority = 1002 },
				{ module = "utils.hover_lsp", priority = 1001 },
				{ module = "hover.providers.man", priority = 150 },
				"hover.providers.gh",
				"hover.providers.gh_user",
				"hover.providers.jira",
				"hover.providers.fold_preview",
				"hover.providers.highlight",
			},
			preview_opts = {
				border = "rounded",
				max_width = 80,
			},
		})
	end,
}
