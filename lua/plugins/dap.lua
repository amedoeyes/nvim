return {
	"mfussenegger/nvim-dap",
	dependencies = {
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
					"<leader>du",
					function()
						require("dapui").toggle()
					end,
					desc = "Debugger UI",
				},
				{
					"<leader>dw",
					function()
						require("dap.ui.widgets").hover()
					end,
					desc = "Debugger widgets",
				},
			},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				handlers = {},
			},
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local icons = require("core.util").icons

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
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Debugger run to cursor",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Debugger step into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Debugger step over",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Debugger step out",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Debugger pause",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Debugger up",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Debugger down",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Debugger run last",
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
