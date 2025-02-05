return {
	"monaqa/dial.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.constant.alias.bool,
				augend.date.alias["%Y/%m/%d"],
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.semver.alias.semver,
				augend.constant.new({
					elements = {
						"first",
						"second",
						"third",
						"fourth",
						"fifth",
						"sixth",
						"seventh",
						"eighth",
						"ninth",
						"tenth",
					},
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = {
						"Monday",
						"Tuesday",
						"Wednesday",
						"Thursday",
						"Friday",
						"Saturday",
						"Sunday",
					},
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = {
						"January",
						"February",
						"March",
						"April",
						"May",
						"June",
						"July",
						"August",
						"September",
						"October",
						"November",
						"December",
					},
					word = true,
					cyclic = true,
				}),
			},
			markdown = {
				augend.misc.alias.markdown_header,
			},
			python = {
				augend.constant.new({
					elements = {
						"True",
						"False",
					},
					word = true,
					cyclic = true,
				}),
			},
		})
	end,
	keys = {
		{
			"<C-a>",
			function() require("dial.map").manipulate("increment", "normal") end,
			desc = "Increment",
		},
		{
			"<C-x>",
			function() require("dial.map").manipulate("decrement", "normal") end,
			desc = "Decrement",
		},
		{
			"g<C-a>",
			function() require("dial.map").manipulate("increment", "gnormal") end,
			desc = "Increment",
		},
		{
			"g<C-x>",
			function() require("dial.map").manipulate("decrement", "gnormal") end,
			desc = "Decrement",
		},
		{
			"<C-a>",
			function() require("dial.map").manipulate("increment", "visual") end,
			desc = "Increment",
			mode = "v",
		},
		{
			"<C-x>",
			function() require("dial.map").manipulate("decrement", "visual") end,
			desc = "Decrement",
			mode = "v",
		},
		{
			"g<C-a>",
			function() require("dial.map").manipulate("increment", "gvisual") end,
			desc = "Increment",
			mode = "v",
		},
		{
			"g<C-x>",
			function() require("dial.map").manipulate("decrement", "gvisual") end,
			desc = "Decrement",
			mode = "v",
		},
	},
}
