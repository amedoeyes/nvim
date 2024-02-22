local util = require("core.util")
local command = vim.api.nvim_create_user_command
local fn = vim.fn

local function create_script(path, shabang)
	local file = io.open(path, "w")

	if file then
		file:write(shabang .. "\n\n")
		file:close()

		fn.system("chmod +x " .. path)

		vim.cmd("e " .. path)
		vim.cmd("2")
	else
		vim.notify("Failed to create file", vim.log.levels.ERROR)
	end
end

command("CreateBash", function()
	local path = fn.input("Path: ", fn.getcwd() .. "/", "file")
	create_script(path, "#!/usr/bin/env bash")
end, {})

command("CreatePython", function()
	local path = fn.input("Path: ", fn.getcwd() .. "/", "file")
	create_script(path, "#!/usr/bin/python3")
end, {})

command("ProjectRoot", function()
	vim.cmd("cd " .. util.get_root_dir())
end, {})
