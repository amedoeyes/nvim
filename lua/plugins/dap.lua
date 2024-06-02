return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = { all_references = true },
			keys = {
				{ "<leader>dv", function() vim.cmd("DapVirtualTextToggle") end, desc = "Debugger toggle virtual text" },
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			dependencies = "nvim-neotest/nvim-nio",
			opts = {
				expand_lines = false,
				floating = { border = "rounded" },
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({ reset = true }) end
				dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
				dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
			end,
			keys = {
				{ "<leader>de", function() require("dapui").eval() end, desc = "Debugger evaluate" },
				{ "<leader>du", function() require("dapui").toggle({ reset = true }) end, desc = "Debugger UI" },
			},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				handlers = {
					function(config)
						local ok, debugger_opts = pcall(require, "debuggers." .. config.name)
						config = vim.tbl_extend("force", config, ok and debugger_opts or {})
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			},
		},
	},
	lazy = true,
	config = function()
		vim.fn.sign_define("DapStopped", { text = "" })
		vim.fn.sign_define("DapBreakpoint", { text = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "" })
		vim.fn.sign_define("DapLogPoint", { text = "" })
	end,
	keys = {
		{
			"<leader>dB",
			function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
			desc = "Debugger add condition breakpoint",
		},
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debugger toggle breakpoint" },
		{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debugger run to cursor" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Debugger continue" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "Debugger run last" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Debugger step into" },
		{ "<leader>dO", function() require("dap").step_out() end, desc = "Debugger step out" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Debugger step over" },
		{ "<leader>dp", function() require("dap").pause() end, desc = "Debugger pause" },
		{ "<leader>ds", function() require("dap").session() end, desc = "Debugger session" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Debugger terminate" },
	},
}
