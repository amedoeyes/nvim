vim.diagnostic.config({
	float = {
		style = "minimal",
		border = "rounded",
		header = "",
	},
})

return {
	{
		"goolord/alpha-nvim",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
      ███    ███████    ███      
    ███    ███     ███    ███    
  ███     ███       ███     ███  
███       ███       ███       ███
  ███     ███       ███     ███  
    ███    ███     ███    ███    
      ███    ███████    ███      
    ]]

			dashboard.section.header.val = vim.split(logo, "\n")
		end,
		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				callback = function()
					dashboard.section.footer.val = ""
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local icons = require("lazyvim.config").icons

			return {
				options = {
					theme = "eyes",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
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
							separator = "",
							padding = { left = 1, right = 0 },
							colored = false,
						},
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {},
					lualine_y = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
						},
						{
							function()
								return "  " .. require("dap").status()
							end,
							cond = function()
								return package.loaded["dap"] and require("dap").status() ~= ""
							end,
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							colored = false,
						},
					},
					lualine_z = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location" },
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
	{
		"SmiteshP/nvim-navic",
		opts = {
			highlight = false,
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local icons = require("nvim-web-devicons").get_icons()

			for _, icon in pairs(icons) do
				icon.color = "#808080"
				icon.cterm_color = "128"
			end
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			window = {
				border = "rounded",
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			presets = {
				lsp_doc_border = true,
			},
		},
	},
}
