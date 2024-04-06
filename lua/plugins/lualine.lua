return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VimEnter",
	opts = function()
		local icons = require("core.icons")

		return {
			options = {
				theme = "eyes",
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "dashboard" },
				},
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
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
						colored = false,
					},
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
						colored = false,
					},
					{
						"filename",
						file_status = false,
					},
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return require("noice").api.status.mode.has()
						end,
						color = false,
					},
				},
				lualine_y = {
					{ "progress" },
				},
				lualine_z = {
					{ "location" },
				},
			},
			extensions = { "lazy", "neo-tree", "toggleterm" },
		}
	end,
}
