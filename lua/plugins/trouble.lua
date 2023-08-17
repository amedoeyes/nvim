return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "TroubleToggle", "Trouble" },
	opts = {
		use_diagnostic_signs = true,
	},
	keys = {
		{
			"<leader>xd",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			desc = "Document diagnostics",
		},
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Workspace diagnostics",
		},
		{
			"]q",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Next quickfix",
		},
		{
			"[q",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			desc = "Previous quickfix",
		},
	},
}
