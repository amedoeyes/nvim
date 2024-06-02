return {
	configurations = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = function()
				local args = vim.fn.input("Arguments: ")
				if args == "" then return nil end
				return vim.split(args, " ")
			end,
		},
		{
			name = "Attach",
			type = "codelldb",
			request = "attach",
			pid = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	},
}
