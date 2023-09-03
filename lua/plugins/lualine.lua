return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{
			"linrongbin16/lsp-progress.nvim",
			opts = {
				spinner = {
					"",
					"󰪞",
					"󰪟",
					"󰪠",
					"󰪡",
					"󰪢",
					"󰪣",
					"󰪤",
					"󰪥",
				},
				client_format = function(client_name, spinner, series_messages)
					return #series_messages > 0 and (client_name .. " " .. spinner)
				end,

				format = function(client_messages)
					return #client_messages > 0 and (table.concat(client_messages, " "))
				end,
			},
			config = function(_, opts)
				require("lsp-progress").setup(opts)

				vim.api.nvim_create_autocmd("User LspProgressStatusUpdated", {
					group = vim.api.nvim_create_augroup("lualine_augroup", {}),
					callback = function()
						require("lualine").refresh()
					end,
				})
			end,
		},
	},
	event = "VimEnter",
	opts = function()
		local icons = require("core.util").icons

		return {
			options = {
				theme = "eyes",
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha" },
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
					{ "require('lsp-progress').progress()" },
				},
				lualine_y = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
						color = false,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = false,
					},
				},
				lualine_z = {
					{ "progress" },
					{ "location" },
				},
			},
			extensions = { "lazy", "neo-tree", "toggleterm", "trouble" },
		}
	end,
}
