local deps = require("mini.deps")

deps.later(function() require("mini.ai").setup() end)

deps.later(function()
	local clue = require("mini.clue")
	clue.setup({
		triggers = {
			{ mode = "n", keys = "<leader>" },
			{ mode = "x", keys = "<leader>" },

			{ mode = "i", keys = "<C-x>" },

			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			{ mode = "n", keys = "<C-w>" },

			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},
		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
		},
		window = {
			config = {
				width = "auto",
			},
		},
	})
end)

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
	vim.keymap.set(
		"n",
		"<leader>go",
		function() diff.toggle_overlay(0) end,
		{ desc = "Git diff overlay" }
	)
end)

deps.now(function()
	local files = require("mini.files")
	files.setup({
		options = { permanent_delete = false },
		mappings = {
			go_in = "",
			go_in_plus = "L",
			go_out = "",
			go_out_plus = "H",
		},
	})
	vim.keymap.set("n", "<leader>fe", files.open, { desc = "File explorer" })
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
