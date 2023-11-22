local status, neotest = pcall(require, 'neotest')
if (not status) then return end

neotest.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})


local cmd = vim.api.nvim_create_user_command
cmd("NeotestSummary", function() require("neotest").summary.toggle() end, {})
cmd("NeotestFile", function() require("neotest").run.run(vim.fn.expand("%")) end, {})
cmd("Neotest", function() require("neotest").run.run(vim.fn.getcwd()) end, {})
cmd("NeotestNearest", function() require("neotest").run.run() end, {})
cmd("NeotestDebug", function() require("neotest").run.run({ strategy = "dap" }) end, {})
cmd("NeotestAttach", function() require("neotest").run.attach() end, {})
cmd("NeotestOutput", function() require("neotest").output.open() end, {})
