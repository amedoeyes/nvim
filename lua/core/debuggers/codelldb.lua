local dap = require("dap")

return {
	adapter = {
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.exepath("codelldb"),
			args = { "--port", "${port}" },
		},
	},
	configurations = {
		{
			type = "codelldb",
			request = "launch",
			name = "Launch binary",
			program = function()
				local path = vim.fn.input({
					prompt = "Path to executable: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				})
				return (path and path ~= "") and path or dap.ABORT
			end,
			cwd = "${workspaceFolder}",
		},
		{
			type = "codelldb",
			request = "attach",
			name = "Attach to process",
			pid = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "codelldb",
			request = "launch",
			name = "Launch xmake target",
			program = function()
				return coroutine.create(function(dap_run_co)
					local cmd = vim.system({ "xmake", "show", "-l", "targets", "--json" }):wait()
					local targets = vim.json.decode(cmd.stdout)
					vim.ui.select(targets, {
						prompt = "Select target",
						format_item = function(item)
							return item
						end,
					}, function(choice)
						cmd = vim.system({ "xmake", "show", "-t", choice }):wait()
						local root = vim.fs.root(0, "xmake.lua")
						local filepath = root .. "/" .. string.sub(vim.split(cmd.stdout, "\n")[4], 17)
						coroutine.resume(dap_run_co, filepath)
					end)
				end)
			end,
			cwd = function()
				return vim.fs.root(0, "xmake.lua")
			end,
		},
	},
	filetypes = { "c", "cpp" },
}
