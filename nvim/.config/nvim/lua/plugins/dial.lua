return {
	"monaqa/dial.nvim",
	keys = {
		{
			"+",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			desc = "Increment number under cursor",
		},
		{
			"-",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			desc = "Decrement number under cursor",
		},
		{
			"+",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "v",
			desc = "Increment numbers in selection",
		},
		{
			"-",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "v",
			desc = "Decrement numbers in selection",
		},
		{
			"g+",
			function()
				require("dial.map").manipulate("increment", "gvisual")
			end,
			mode = "v",
			desc = "Increment all numbers in selection",
		},
		{
			"g-",
			function()
				require("dial.map").manipulate("decrement", "gvisual")
			end,
			mode = "v",
			desc = "Decrement all numbers in selection",
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.integer.alias.binary,
				augend.integer.alias.octal,
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%d.%m.%Y"],
				augend.date.alias["%H:%M:%S"],
				augend.date.alias["%H:%M"],
				augend.constant.alias.bool,
				augend.constant.alias.Bool,
				augend.semver.alias.semver,
				augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
				augend.constant.new({ elements = { "let", "const" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
				augend.hexcolor.new({ case = "lower" }),
			},
		})
	end,
}
