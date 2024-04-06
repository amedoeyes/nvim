return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			asm = { "asmfmt" },
			c = { "clang_format" },
			cmake = { "gersemi" },
			cpp = { "clang_format" },
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
			tex = { "latexindent" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			zsh = { "shfmt" },
			["_"] = { "trim_whitespace" },
		},
		formatters = {
			latexindent = { prepend_args = { "-g", "/dev/null" } },
		},
		format_on_save = function()
			if not vim.g.autoformat then
				return
			end

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
				require("conform").format({
					timeout_ms = 500,
					lsp_fallback = true,
				})
			end,
			desc = "Format",
		},
	},
}
