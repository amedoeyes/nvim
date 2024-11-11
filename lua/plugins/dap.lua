return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio", lazy = true },
			opts = {
				expand_lines = false,
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({ reset = true })
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
			keys = {
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "Debugger evaluate",
					mode = { "n", "v" },
				},
				{
					"<leader>du",
					function()
						require("dapui").toggle({ reset = true })
					end,
					desc = "Debugger UI",
				},
			},
		},
	},
	lazy = true,
	opts = {
		debuggers = {
			"codelldb",
		},
		icons = {
			Stopped = "",
			Breakpoint = "",
			BreakpointCondition = "",
			BreakpointRejected = "",
			LogPoint = "",
		},
	},
	config = function(_, opts)
		local dap = require("dap")
		for _, debugger in ipairs(opts.debuggers) do
			local config = require("core.debuggers.codelldb")
			dap.adapters[debugger] = config.adapter
			for _, filetype in ipairs(config.filetypes) do
				dap.configurations[filetype] = config.configurations
			end
		end
		for name, icon in pairs(opts.icons) do
			vim.fn.sign_define("Dap" .. name, { text = icon })
		end
	end,
	keys = {
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Condition: "))
			end,
			desc = "Debugger add condition breakpoint",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debugger toggle breakpoint",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Debugger run to cursor",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debugger continue",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Debugger run last",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Debugger step into",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Debugger step out",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Debugger step over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Debugger pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Debugger toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Debugger session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Debugger terminate",
		},
	},
}
