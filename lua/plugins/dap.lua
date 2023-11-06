return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				virt_text_pos = "eol",
				all_references = true,
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				expand_lines = false,
				floating = {
					border = "rounded",
				},
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
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
				},
				{
					"<leader>du",
					function()
						require("dapui").toggle()
					end,
					desc = "Debugger UI",
				},
			},
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local dap = require("dap")
		local debuggers = {
			codelldb = require("dap.codelldb"),
		}

		for debugger, opts in pairs(debuggers) do
			dap.adapters[debugger] = opts.adapter

			for _, filetype in pairs(opts.filetypes) do
				dap.configurations[filetype] = opts.configurations
			end
		end

		local icons = require("core.icons")

		for name, sign in pairs(icons.dap) do
			vim.fn.sign_define("Dap" .. name, { text = sign })
		end
	end,
	keys = {
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debugger add Condition breakpoint",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Debugger run to cursor",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Debugger step out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debugger toggle breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debugger continue",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Debugger step into",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Debugger run last",
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
