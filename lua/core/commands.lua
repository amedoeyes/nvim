local util = require("core.util")
local command = vim.api.nvim_create_user_command
local fn = vim.fn

command("CreateBash", function()
	local path = fn.input("Path: ", fn.getcwd() .. "/", "file")
	local file = io.open(path, "w")

	if file then
		file:write("#!/bin/bash\n\n")
		file:close()

		fn.system("chmod +x " .. path)

		vim.cmd("e " .. path)
		vim.cmd("2")
	else
		vim.notify("Failed to create file", vim.log.levels.ERROR)
	end
end, {})

command("ProjectRoot", function()
	vim.cmd("cd " .. util.get_root())
end, {})
