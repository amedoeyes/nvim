local deps = require("mini.deps")

deps.now(function()
	local oil = require("oil")
	oil.setup({
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
	})
	vim.keymap.set("n", "-", function() oil.open() end, { desc = "File explorer" })
end)
