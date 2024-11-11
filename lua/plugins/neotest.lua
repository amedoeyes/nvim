return {
	"nvim-neotest/neotest",
	dependencies = {
		{ "nvim-neotest/nvim-nio", lazy = true },
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
		{ "fredrikaverpil/neotest-golang", version = "*" },
	},
	lazy = true,
	opts = function()
		return {
			adapters = {
				require("neotest-golang"),
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
		}
	end,
	keys = {
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run test file",
		},
		{
			"<leader>tT",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run all test files",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run last test",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show test output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Test output panel",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop test",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Watch test",
		},
	},
}
