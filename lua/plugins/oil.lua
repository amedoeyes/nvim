return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	lazy = false,
	opts = {
		columns = {
			{ "icon", add_padding = false },
		},
		view_options = {
			show_hidden = true,
		},
		delete_to_trash = true,
		keymaps = {
			["<C-v>"] = {
				"actions.select",
				opts = { vertical = true },
				desc = "Open the entry in a vertical split",
			},
			["<C-s>"] = {
				"actions.select",
				opts = { horizontal = true },
				desc = "Open the entry in a horizontal split",
			},
			["<C-h>"] = false,
			["gd"] = function()
				vim.g.oil_columns_details = not vim.g.oil_columns_details
				if vim.g.oil_columns_details then
					require("oil").set_columns({
						"permissions",
						"size",
						"mtime",
						{ "icon", add_padding = false },
					})
				else
					require("oil").set_columns({
						{ "icon", add_padding = false },
					})
				end
			end,
			desc = "Toggle details",
		},
		float = { border = "single" },
		confirmation = { border = "single" },
		progress = { border = "single" },
		ssh = { border = "single" },
		keymaps_help = { border = "single" },
	},
}
