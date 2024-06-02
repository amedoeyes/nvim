return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = "CopilotChat",
	opts = {
		question_header = "  " .. vim.env.USER .. " ",
		answer_header = "  Copilot ",
		show_folds = false,
		show_help = false,
		auto_insert_mode = true,
		window = { width = 0.4 },
		selection = function(source)
			local select = require("CopilotChat.select")
			return select.visual(source) or select.buffer(source)
		end,
		mappings = {
			complete = { insert = "" },
		},
	},
	config = function(_, opts)
		require("CopilotChat").setup(opts)
		require("CopilotChat.integrations.cmp").setup()
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			group = vim.api.nvim_create_augroup("copilot", { clear = true }),
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})
	end,
}
