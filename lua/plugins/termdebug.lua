local deps = require("mini.deps")

deps.later(function()
	vim.g.termdebug_config = { sign = "" }
	vim.cmd.packadd("termdebug")
end)
