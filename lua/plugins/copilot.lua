return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			show_folds = false,
			show_help = false,
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				group = vim.api.nvim_create_augroup("copilot", { clear = true }),
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})
		end,
	},
}
