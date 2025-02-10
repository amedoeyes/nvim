local deps = require("mini.deps")

deps.later(function() require("mini.ai").setup() end)

deps.now(function()
	local diff = require("mini.diff")
	diff.setup({
		view = {
			style = "sign",
			signs = {
				add = "▎",
				change = "▎",
				delete = "",
			},
		},
	})
	vim.keymap.set("n", "<leader>go", function() diff.toggle_overlay(0) end)
end)

deps.now(function()
	require("mini.icons").setup({
		extension = {
			h = { glyph = "" },
			hpp = { glyph = "" },
		},
		filetype = {
			c = { glyph = "" },
			cpp = { glyph = "" },
			cs = { glyph = "" },
		},
	})
	package.preload["nvim-web-devicons"] = function()
		require("mini.icons").mock_nvim_web_devicons()
		return package.loaded["nvim-web-devicons"]
	end
end)

deps.later(function() require("mini.move").setup() end)

deps.later(
	function()
		require("mini.operators").setup({
			evaluate = { prefix = "go=" },
			exchange = { prefix = "gox" },
			multiply = { prefix = "gom" },
			replace = { prefix = "gor" },
			sort = { prefix = "gos" },
		})
	end
)

deps.later(function() require("mini.pairs").setup() end)

deps.later(
	function()
		require("mini.surround").setup({
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		})
	end
)
