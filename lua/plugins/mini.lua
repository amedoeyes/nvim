return {
	"echasnovski/mini.nvim",
	lazy = false,
	init = function()
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
	opts = {
		ai = {},
		diff = {
			view = {
				style = "sign",
				signs = {
					add = "▎",
					change = "▎",
					delete = "",
				},
			},
		},
		icons = {
			extension = {
				h = { glyph = "" },
				hpp = { glyph = "" },
			},
			filetype = {
				c = { glyph = "" },
				cpp = { glyph = "" },
				cs = { glyph = "" },
			},
		},
		move = {},
		operators = {
			evaluate = { prefix = "go=" },
			exchange = { prefix = "gox" },
			multiply = { prefix = "gom" },
			replace = { prefix = "gor" },
			sort = { prefix = "gos" },
		},
		pairs = {},
		surround = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},
	config = function(_, opts)
		for module, module_opts in pairs(opts) do
			require("mini." .. module).setup(module_opts)
		end
	end,
	keys = {
		{
			"<leader>go",
			function() require("mini.diff").toggle_overlay(0) end,
			desc = "Toggle diff overlay",
		},
	},
}
