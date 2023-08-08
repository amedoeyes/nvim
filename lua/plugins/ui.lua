return {
	{
		"amedoeyes/eyes.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"folke/noice.nvim",

		dependencies = {
			"MunifTanjim/nui.nvim",
			{

				"rcarriga/nvim-notify",
				opts = {
					render = "minimal",
					timeout = 0,
					max_height = function()
						return math.floor(vim.o.lines * 0.75)
					end,
					max_width = function()
						return math.floor(vim.o.columns * 0.75)
					end,
				},
			},
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				progress = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				win_options = {
					winblend = 0,
				},
			},
			select = {
				win_options = {
					winblend = 0,
				},
				nui = {
					win_options = {
						winblend = 0,
					},
				},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = function()
			local groups = require("bufferline.groups")

			return {
				options = {
					close_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
					right_mouse_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(_, _, diag)
						local icons = require("config.icons").diagnostics
						local ret = (diag.error and icons.Error .. diag.error .. " " or "")
							.. (diag.warning and icons.Warn .. diag.warning or "")

						return vim.trim(ret)
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo-tree",
							highlight = "Directory",
							text_align = "left",
							separator = true,
						},
					},
					tab_size = 10,
					show_buffer_close_icons = false,
					separator_style = { "|", "|" },
					indicator = {
						style = "none",
					},
					groups = {
						items = {
							groups.builtin.pinned:with({ icon = "" }),
						},
					},
				},
				highlights = require("eyes.theme").bufferline,
			}
		end,
	},
	{
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
			},
		},
		opts = function()
			local icons = require("config.icons")
			local augroup = vim.api.nvim_create_augroup("lualine_augroup", {})

			vim.api.nvim_create_autocmd("User LspProgressStatusUpdated", {
				group = augroup,
				callback = require("lualine").refresh,
			})

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
						{ "filename" },
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
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			show_current_context = true,
			show_trailing_blankline_indent = false,
			-- use_treesitter = true,
			-- use_treesitter_scope = true,
		},
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
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
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			dashboard.opts.layout[1].val = 8

			return dashboard
		end,
		config = function(_, dashboard)
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)
		end,
	},
}
