return {
	"folke/persistence.nvim",
	cmd = {
		"PersistenceStart",
		"PersistenceStop",
		"PersistenceRestore",
		"PersistenceRestoreLast",
		"PersistenceSave",
	},
	opts = { options = vim.opt.sessionoptions:get() },
	config = function(_, opts)
		local persistence = require("persistence")
		persistence.setup(opts)
		local command = vim.api.nvim_create_user_command
		command("PersistenceStart", function() persistence.start() end, {})
		command("PersistenceStop", function() persistence.stop() end, {})
		command("PersistenceRestore", function() persistence.load() end, {})
		command("PersistenceRestoreLast", function() persistence.load({ last = true }) end, {})
		command("PersistenceSave", function() persistence.save() end, {})
	end,
}
