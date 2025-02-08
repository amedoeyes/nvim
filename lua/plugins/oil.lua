return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {
		columns = {
			"permissions",
			"size",
			"mtime",
			{ "icon", add_padding = false },
		},
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name) return name == ".." end,
		},
		delete_to_trash = true,
		float = { border = "single" },
		confirmation = { border = "single" },
		progress = { border = "single" },
		ssh = { border = "single" },
		keymaps_help = { border = "single" },
	},
	keys = {
		{ "-", function() vim.cmd("Oil") end, desc = "File explorer" },
	},
}
