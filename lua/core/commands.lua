local util = require("core.util")
local command = vim.api.nvim_create_user_command
local fn = vim.fn

local function create_script(path, env)
	local file = io.open(path, "w")
	if file then
		file:write("#!" .. env .. "\n\n")
		file:close()
		fn.system("chmod +x " .. path)
		vim.cmd("e " .. path)
		vim.cmd("2")
	else
		vim.notify("Failed to create file", vim.log.levels.ERROR)
	end
end

local function create_script_command(name, env)
	command(name, function(opts)
		local path = #opts.args > 0 and opts.args or fn.input("Path: ", fn.getcwd() .. "/", "file")
		create_script(path, env)
	end, { nargs = "?" })
end

create_script_command("CreateBash", "/usr/bin/env bash")
create_script_command("CreatePython", "/usr/bin/python3")
create_script_command("CreateJavaScript", "/usr/bin/node")

command("ProjectRoot", function()
	vim.cmd("cd " .. util.get_root_dir())
end, {})
