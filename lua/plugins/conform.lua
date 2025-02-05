return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	event = { "BufWritePre" },
	init = function() vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()" end,
	opts = {
		formatters_by_ft = {
			asm = { "asmfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			cs = { "csharpier" },
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "black" },
			scss = { "prettier" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
			zsh = { "shfmt" },
			["_"] = { "trim_whitespace" },
		},
		format_on_save = function()
			if not vim.g.autoformat then return end
			return {
				timeout_ms = 1000,
				lsp_fallback = true,
			}
		end,
	},
}
