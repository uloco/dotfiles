local status, none_ls = pcall(require, "null-ls")
if not status then
	return
end

-- Check if an eslint config file exists in the project
local eslint_config_files = {
	-- flat config (eslint >= 8.21)
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
	-- eslintrc (deprecated)
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.yaml",
	".eslintrc.yml",
	".eslintrc.json",
}

local function has_eslint_config(utils)
	return utils.root_has_file(eslint_config_files)
end

---@diagnostic disable-next-line: redundant-parameter
none_ls.setup({
	sources = {
		none_ls.builtins.diagnostics.fish,
		require("none-ls.code_actions.eslint_d").with({
			condition = has_eslint_config,
		}),
		require("none-ls.diagnostics.eslint_d").with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
			condition = has_eslint_config,
		}),
		none_ls.builtins.formatting.prettierd,
	},
})
