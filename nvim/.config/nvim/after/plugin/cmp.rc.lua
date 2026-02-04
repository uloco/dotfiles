local status, cmp = pcall(require, "cmp")
if not status then
	return
end
local lspkind = require("lspkind")

-- npm sources
require("cmp-npm").setup({
	only_latest_version = true,
})

local luasnip = require("luasnip")

-- general cmp setup
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			local copilot_suggestion = require("copilot.suggestion")
			-- if cmp.visible() then
			-- 	cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
			-- elseif copilot_suggestion.is_visible() then
			if copilot_suggestion.is_visible() then
				copilot_suggestion.accept()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-J>"] = cmp.mapping.complete({
			config = {
				sources = cmp.config.sources({ { name = "luasnip" } }),
			},
		}),
		["<A-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}),
	sources = cmp.config.sources({
		{
			name = "npm",
			keyword_length = 4,
		},
		-- { name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lsp_signature_help" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			wirth_text = false,
			maxwidth = {
				-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				-- can also be a function to dynamically calculate max width such as
				-- menu = function() return math.floor(0.45 * vim.o.columns) end,
				menu = 50, -- leading text (labelDetails)
				abbr = 50, -- actual suggestion item
			},
		}),
	},
})

-- Cmdline mappings with arrow key support
local cmdline_mapping = cmp.mapping.preset.cmdline({
	["<Up>"] = { c = cmp.mapping.select_prev_item() },
	["<Down>"] = { c = cmp.mapping.select_next_item() },
})

-- Use buffer source for `/`
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmdline_mapping,
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
	mapping = cmdline_mapping,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
