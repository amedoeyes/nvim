return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local linters_by_ft = {
			python = { "flake8" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },
			c = { "betty_style", "betty_doc" },
			cpp = { "betty_style", "betty_doc" },
		}

		local linters = {
			betty_style = require("linters.betty_style"),
			betty_doc = require("linters.betty_doc"),
		}

		local lint = require("lint")

		lint.linters_by_ft = linters_by_ft
		lint.linters = linters

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
