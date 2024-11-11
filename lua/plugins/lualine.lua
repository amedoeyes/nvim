return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
		{ "folke/noice.nvim", lazy = true },
	},
	lazy = false,
	opts = function()
		local icons = vim.diagnostic.config().signs.text
		return {
			options = {
				theme = "eyes",
				globalstatus = true,
				section_separators = "",
				component_separators = "",
				always_show_tabline = false,
			},
			tabline = {
				lualine_a = {
					{
						"tabs",
						mode = 1,
						max_length = vim.o.columns,
						show_modified_status = false,
						tabs_color = { active = "TabLineSel", inactive = "TabLine" },
					},
				},
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
						cond = function()
							return vim.api.nvim_buf_get_name(0) ~= ""
						end,
					},
					{
						"filename",
						padding = { left = 0 },
						symbols = {
							modified = "●",
							readonly = "",
							unnamed = "",
							newfile = "󰎔",
						},
						cond = function()
							return vim.api.nvim_buf_get_name(0) ~= ""
						end,
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
				lualine_y = {},
				lualine_z = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			},
			extensions = {
				"lazy",
				"man",
				"mason",
				"nvim-dap-ui",
				"oil",
			},
		}
	end,
}
