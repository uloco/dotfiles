return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
			})

			local cmd = vim.api.nvim_create_user_command
			cmd("NeotestSummary", function() neotest.summary.toggle() end, {})
			cmd("NeotestFile", function() neotest.run.run(vim.fn.expand("%")) end, {})
			cmd("Neotest", function() neotest.run.run(vim.fn.getcwd()) end, {})
			cmd("NeotestNearest", function() neotest.run.run() end, {})
			cmd("NeotestDebug", function() neotest.run.run({ strategy = "dap" }) end, {})
			cmd("NeotestAttach", function() neotest.run.attach() end, {})
			cmd("NeotestOutput", function() neotest.output.open() end, {})
		end,
		cmd = {
			"NeotestSummary",
			"NeotestFile",
			"Neotest",
			"NeotestNearest",
			"NeotestDebug",
			"NeotestAttach",
			"NeotestOutput",
		},
		keys = {
			{ "<leader>tn", function() require("neotest").run.run() end, desc = "Test nearest" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test file" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary" },
			{ "<leader>to", function() require("neotest").output.open() end, desc = "Test output" },
			{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
			{ "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to nearest test" },
		},
	},
}
