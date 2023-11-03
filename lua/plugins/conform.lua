return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			cmake = { "gersemi" },
			cpp = { "clang_format" },
			c = { "clang_format" },
			css = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			python = { "black" },
			sh = { "shfmt" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			zsh = { "shfmt" },
			["_"] = { "trim_whitespace" },
		},
		formatters = {
			gersemi = {
				command = "gersemi",
				args = { "-" },
				stdin = true,
			},
			clang_format = {
				command = "clang-format",
				args = { "--assume-filename", "$FILENAME" },
				stdin = true,
			},
		},
		format_on_save = function()
			if not vim.g.autoformat then
				return
			end

			vim.notify("Formatting...", vim.log.levels.INFO)

			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	},
	keys = {
		{
			"<leader>cf",
			function()
				vim.notify("Formatting...", vim.log.levels.INFO)

				require("conform").format({
					timeout_ms = 500,
					lsp_fallback = true,
				})
			end,
			desc = "Format",
		},
	},
}
