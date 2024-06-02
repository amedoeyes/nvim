return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = function()
		local icons = vim.diagnostic.config().signs.text
		return {
			options = {
				theme = "eyes",
				globalstatus = true,
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = icons and icons[vim.diagnostic.severity.ERROR],
							warn = icons and icons[vim.diagnostic.severity.WARN],
							info = icons and icons[vim.diagnostic.severity.INFO],
							hint = icons and icons[vim.diagnostic.severity.HINT],
						},
					},
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					{
						"filename",
						file_status = false,
						padding = { left = 0 },
					},
				},
				lualine_x = {
					{
						---@diagnostic disable-next-line: undefined-field
						require("noice").api.status.mode.get,
						---@diagnostic disable-next-line: undefined-field
						cond = require("noice").api.status.mode.has,
					},
				},
				lualine_y = { { "progress" } },
				lualine_z = { { "location" } },
			},
			extensions = {
				"lazy",
				"man",
				"mason",
				"neo-tree",
				"nvim-dap-ui",
				"toggleterm",
				"trouble",
			},
		}
	end,
}
