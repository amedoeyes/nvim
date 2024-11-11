return {
	"stevearc/dressing.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim", lazy = false },
	},
	lazy = true,
	init = function()
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
	end,
	opts = function()
		return {
			input = {
				border = "single",
				insert_only = false,
			},
			select = {
				telescope = require("telescope.themes").get_dropdown({
					borderchars = {
						prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
				}),
			},
		}
	end,
}
