return {
	"folke/persistence.nvim",
	cmd = {
		"PersistenceStart",
		"PersistenceStop",
		"PersistenceSave",
		"PersistenceRestore",
		"PersistenceRestoreLast",
	},
	event = "BufReadPre",
	config = function()
		local persistence = require("persistence")
		persistence.setup()
		vim.api.nvim_create_user_command("PersistenceStart", function()
			persistence.start()
		end, {})
		vim.api.nvim_create_user_command("PersistenceStop", function()
			persistence.stop()
		end, {})
		vim.api.nvim_create_user_command("PersistenceRestore", function()
			persistence.load()
		end, {})
		vim.api.nvim_create_user_command("PersistenceRestoreLast", function()
			persistence.load({ last = true })
		end, {})
		vim.api.nvim_create_user_command("PersistenceSave", function()
			persistence.save()
		end, {})
	end,
}
